# HttpClient
=====
####下方有中文说明
HttpClient is a easy-to-use, high efficiency and simplify Http request class.I reference SVHTTPRequest and improve some features.
##Key Features
* Inherit NSOperation.
* Do not instantiated HttpClient class, use static HttpClient class funciton complete all http requests.
* Use block complete call-back, and can monitor download&upload process.
* Support globle settings, and you can also customize http request.
* Support cache feature by Url and clear cache.
* Can cancel all request, cancel requeset by request token.
* Support functional programming.

<br/>
##Requirements 
Xcode 7.1 and iOS 8.0(the lasted swift grammar)

##Installation
if you want to use cocopods, just pod 'HttpClient'.
<br>
if you want to use file, just pod copy the HttpClient.swift to your project .
<br>
##How To Use It 
<br>
###Setp1: configration the http environment
  use the HttpClient setGlobal serious static functions to configration the http environment
  ```swift
  HttpClient.setGlobalCachePolicy(NSURLRequestCachePolicy.UseProtocolCachePolicy) //set the GlobalCachePolicy
  HttpClient.setGlobalNeedSendParametersAsJSON(false) // set need set parameters as json
  HttpClient.setGlobalUsername("yourUserName") 
  HttpClient.setGlobalPassword("123456")
  HttpClient.setGlobalTimeoutInterval(40) //all request time out
  HttpClient.setGlobalUserAgent("Firefox") // set useragent
  ```
  if you do not configration the http environment, the HttpClient will use the default config which are:
  ```swift
  GlobalCachePolicy//(default value is NSURLRequestCachePolicy.UseProtocolCachePolicy ),
  GlobalNeedSendParametersAsJSON//(the default value is false),
  GlobalTimeoutInterval//(the default value is 20), 
  GlobalUserAgent//(the default value is HttpClient)  
  ```
###Setp2 Use HttpClient static function
  call the HttpClient static function once is to creat a HttpClient instance, the initialize function is
  ```swift
  private init(address:String,method:httpMethod,parameters:Dictionary<String,AnyObject>?, cache:Int,cancelToken:String?,queryPara:Dictionary<String,AnyObject>?, requestOptions:Dictionary<String,AnyObject>?,headerFields:Dictionary<String,AnyObject>?, progress:((progress:Float)->())?,complettion:(response:AnyObject?,urlResponse:NSHTTPURLResponse?,error:NSError?)->()){}
  ```
  you will note this is a private construction. and so you can not call it directly. let's see the parameters
  ```swift
  address:String// the request address,
  method:httpMethod//there is a enum, specifically request method
  parameters:Dictionary<String,AnyObject>?// this is the request parameters, when you use get method.the parameters will be added to the url, and when tou use the pose method. all the parameters will be wraped in the http post content.
  cache:Int//if you need cache this url, you can set the cache time bigger than 0. it any work at Get method, in post method this feature can not work
  cancelToken:String?//this is the cancel token, if you want cancel this request, just call the static funtion HttpClient.cancelRequestWithIndentity(token:string)
  queryPara:Dictionary<String,AnyObject>?// this parameter is special.  you can use it on this condition. when you use post method but also want to add some parameters to the url, then use this parameter
  requestOptions:Dictionary<String,AnyObject>?// this parameter let you personalization this request.make it not obey the global config. for instance, if you need set this request timeout . you need add timeout in the dictionary. and pass it to the request.
  headerFields:Dictionary<String,AnyObject>?// the paramter is to set the request header.
  progress:((progress:Float)->())?// this is the upload&download progress
  complettion:(response:AnyObject?,urlResponse:NSHTTPURLResponse?,error:NSError?)->())// this is the completion handler response is a nsdata object, if error occur, the response eill be nil and you can fetch the error info from error
  ```
###Step3 Handle the callback block
  the last thing is to handle the callback block,it's very simple.
  ```swift
  HttpClient.get("http://www.baidu.com", parameters: nil, cache: 20, cancelToken: nil, complettion: { (response, urlResponse, error) -> () in
                if error != nil{
                    println("there is a error\(error)")
                    return
                }
                if let data = response as? NSData{
                    if let result = NSString(data: data, encoding: NSUTF8StringEncoding){
                      println(result)
                    }
                }
            })

  First: check the error filed, if error exist, handle the error and display the correct message to the user
  Second: convert the response to the NSData, accord the request result, it can be a Image NSData , Text NSData or JSON.
  Third: convert the NSData to the Model or Object and use it
  ```
<br/>
Or you can also use functional programming style to complete http request
```swift
let path: AnyObject? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
let myPath = (path as! NSString).stringByAppendingPathComponent("img.jpg")
let httpOption = [HttpClientOption.SavePath:myPath,HttpClientOption.TimeOut:NSNumber(int: 100)]
let para = ["a":"123"]
HttpClientManager.Get("http://img1.gamersky.com/image2015/09/20150912ge_10/gamersky_45origin_89_201591217486B7.jpg").addParams(para).cache(100).requestOptions(httpOption).progress({ (progress) -> () in
                print(progress)
            }).completion({ (response, urlResponse, error) -> () in
                if error != nil{
                    print("there is a error\(error)")
                    return
                }
                if let data = response as? NSData{
                    if let result = UIImage(data: data){
                        let tvc = ImgViewController()
                        tvc.img = result
                        self.navigationController?.pushViewController(tvc, animated: true)
                    }
                }
                
            })
Unlike commom static function, use HttpClientManager functional programming style is more friendly, you do not need set unnecessary parameters to nil.just use . grammar. but if you use Objectice-s, more [] will mill make more improper
```
###Setp4 Other operation 
#####Cache the request:
```swift
cache: 20,
```
 HttpClient can cache the request by url, just pass the number than bigger 0(this is  second unit) to the Cache parameter(only get httpmMehod will work), the HttpClient will cache this request automatically and store the cache as NSData to the APP's Cache fold.if  you use the same url to fire another http request, HttpClient will read all data from cache
<br/>
#####Clear the cache:
```swift
HttpClient.clearUrlCache("www.baidu.com") //if you can clear one specific cache, just pass the cache url
HttpClient.clearCache() //call  clearCache clear all the url cache
```
Not only set cache, you can clear the cache manually, call the static funtion clearUrlCache(url:String) and pass the url that you have set cache, you can call the static funtion clearCache() as well, it can clear all the cache file that the HttpClient created.
<br/>
#####Cancel the request:
```swift
cancelToken: "cancel", set the cancel token
HttpClient.cancelRequestWithIndentity("cancel")  //use cancel token to cancel
HttpClient.cancelAllRequests() //cancel all the request
```
  Cancel http request while the http request is processing is a HttpClient's prime feature it's very simple. when you want to cancel a request, you must set the cancelToken parameter. can you'd better make the cancelToken is unique. then call the static funtion cancelRequestWithIndentity(token:String), pass the cancelToken to this funtion and the HttpClient will cancel this request. as a consequence the result block will not run.meanwhile, if you do not set the cancelToken, you can use the url to cancel the request, call the static funtion cancelRequestsWithPath(url:String) and pass the url. if you want cancel all the request, call the static funtion cancelAllRequests() the HttpClient will terminate all the request that is processing.
<br/>
#####customize the request:
```swift
let httpOption = [HttpClientOption.SavePath:myPath,HttpClientOption.TimeOut:NSNumber(int: 100)]
```
  After set the globel Http environment, for some http request you do not want to obey the globel http environment, you can customize the http request. there are some HttpClientOption you can set,please refer the struct HttpClientOption
<br/>

#####Set username and password:
some website need certificate,it need user provide the username and password.you can use the global static funtion set the global username and password or store the username and password in a dictionary then pass to a specifically request(I have't test this feature)
##### More usage please refer the HttpClientDemo
  
##Contact 
Any issue or problem please contact me:3421902@qq.com, I will be happy fix it






# HttpClient
=====
HttpClient 是一个容易使用，高效率和简易的Http请求类，参考了SVHTTPRequest 同时也改进了不少功能
##关键特点
* 继承于NSOperation.
* 不需要实例化，直接调用HttpClient静态方法完成所有请求.
* 使用Block完成回调，同时可以监视下载&上传过程.
* 支持全局Http环境设置，同时你也可以个性化请求.
* 支持根据Url请求缓存功能，也可以根据Url清空缓存和清空全部缓存.
* 可以根据token取消请求，也可以取消全部请求.
* 支持函数式风格编程.

<br/>
##系统要求 
Xcode 7.1 and iOS 8.0(最新的swift语法)

##安装
如果你用Cocopods,使用pod 'HttpClient'.
<br>
如果你要用文件，只要复制HttpClient.swift到你的项目就行 .
<br>
##怎么使用
<br>
###Setp1: 配置Http环境
  使用HttpClient 静态的setGlobal系列方法来配置全局环境
  ```swift
  HttpClient.setGlobalCachePolicy(NSURLRequestCachePolicy.UseProtocolCachePolicy)
  HttpClient.setGlobalNeedSendParametersAsJSON(false)
  HttpClient.setGlobalUsername("yourUserName") 
  HttpClient.setGlobalPassword("123456")
  HttpClient.setGlobalTimeoutInterval(40)
  HttpClient.setGlobalUserAgent("Firefox")
  ```
  如果你不做这些设置，HttpClient将会使用如下设置:
  ```swift
  GlobalCachePolicy//(默认是 NSURLRequestCachePolicy.UseProtocolCachePolicy ),
  GlobalNeedSendParametersAsJSON//(默认是 is false),
  GlobalTimeoutInterval//(默认是 is 20), 
  GlobalUserAgent//(默认是 is HttpClient)  
  ```
###Setp2 使用HttpClient的一系列get,post静态方法
 每调用一次HttpClient将会实例化一个HttpClient类，HttpClient的初始方法为
  ```swift
  private init(address:String,method:httpMethod,parameters:Dictionary<String,AnyObject>?, cache:Int,cancelToken:String?,queryPara:Dictionary<String,AnyObject>?, requestOptions:Dictionary<String,AnyObject>?,headerFields:Dictionary<String,AnyObject>?, progress:((progress:Float)->())?,complettion:(response:AnyObject?,urlResponse:NSHTTPURLResponse?,error:NSError?)->()){}
  ```
  你会注意到这是一个私有方法。里面有HttpClient的全部参数。下面说说这些参数
  ```swift
  address:String// the request address,
  method:httpMethod//there is a enum, specifically request method
  parameters:Dictionary<String,AnyObject>?// this is the request parameters, when you use get method.the parameters will be added to the url, and when tou use the pose method. all the parameters will be wraped in the http post content.
  cache:Int//if you need cache this url, you can set the cache time bigger than 0. it any work at Get method, in post method this feature can not work
  cancelToken:String?//this is the cancel token, if you want cancel this request, just call the static funtion HttpClient.cancelRequestWithIndentity(token:string)
  queryPara:Dictionary<String,AnyObject>?// this parameter is special.  you can use it on this condition. when you use post method but also want to add some parameters to the url, then use this parameter
  requestOptions:Dictionary<String,AnyObject>?// this parameter let you personalization this request.make it not obey the global config. for instance, if you need set this request timeout . you need add timeout in the dictionary. and pass it to the request.
  headerFields:Dictionary<String,AnyObject>?// the paramter is to set the request header.
  progress:((progress:Float)->())?// this is the upload&download progress
  complettion:(response:AnyObject?,urlResponse:NSHTTPURLResponse?,error:NSError?)->())// this is the completion handler response is a nsdata object, if error occur, the response eill be nil and you can fetch the error info from error
  ```
###Step3 处理回调
  最后一步使用Block处理回调
  ```swift
  HttpClient.get("http://www.baidu.com", parameters: nil, cache: 20, cancelToken: nil, complettion: { (response, urlResponse, error) -> () in
                if error != nil{
                    println("there is a error\(error)")
                    return
                }
                if let data = response as? NSData{
                    if let result = NSString(data: data, encoding: NSUTF8StringEncoding){
                      println(result)
                    }
                }
            })

  第一: 检查是否有错误产生, 如果发生错误, 处理错误同时将错误信息显示出来
  第二: 将 response 转换成Image NSData , Text NSData or JSON.
  第三: 再将其转换成Model或者object使用
  ```
<br/>
同时你也可以用函数式风格来编程
```swift
let path: AnyObject? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
let myPath = (path as! NSString).stringByAppendingPathComponent("img.jpg")
let httpOption = [HttpClientOption.SavePath:myPath,HttpClientOption.TimeOut:NSNumber(int: 100)]
let para = ["a":"123"]
HttpClientManager.Get("http://img1.gamersky.com/image2015/09/20150912ge_10/gamersky_45origin_89_201591217486B7.jpg").addParams(para).cache(100).requestOptions(httpOption).progress({ (progress) -> () in
                print(progress)
            }).completion({ (response, urlResponse, error) -> () in
                if error != nil{
                    print("there is a error\(error)")
                    return
                }
                if let data = response as? NSData{
                    if let result = UIImage(data: data){
                        let tvc = ImgViewController()
                        tvc.img = result
                        self.navigationController?.pushViewController(tvc, animated: true)
                    }
                }
                
            })
不像那些普通静态方法, 使用 HttpClientManager 函数式编程风格使用体验更加友好,你不需要使用null来传递你不需要传的参数，直接 . 语法就行.但是如果你是用Objective-c的话，太多的 [] 也许不合适
```
###Setp4 其他操作
#####缓存请求:
```swift
cache: 20,
```
  HttpClient可以根据Url来缓存请求，只需要在传一个比0大的数，（以秒为单位作为参数来请求。而且只有在Get模式才能使用缓存功能。HttpClient就可以在获取请求数据后将数据以NSData的形式缓存到Cahce目录里，下去再请求这个Url HttpClient会直接从缓存里读取.
<br/>
#####清空缓存:
```swift
HttpClient.clearUrlCache("www.baidu.com") //if you can clear one specific cache, just pass the cache url
HttpClient.clearCache() //call  clearCache clear all the url cache
```
你不仅可以设置缓存，还可以手动清空缓存。调用静态函数clearUrlCache(url:String)传递已经缓存的Url既可。当然你也可以清空全部缓存，调用静态函数clearCache()即可，这样就能清空HttpClient产生的全部缓存.
<br/>
#####取消请求:
```swift
cancelToken: "cancel", set the cancel token
HttpClient.cancelRequestWithIndentity("cancel")  //use cancel token to cancel
HttpClient.cancelAllRequests() //cancel all the request
```
  取消请求也是HttpClient一个重要的功能。合理利用这个功能可以节省大量资源。使用方式非常简单，当你有一个Http请求是需要可以取消的，那么只需要在这个请求的函数中设置cancelToken即可，同时最好设置这个calcelToken是唯一的。然后可以调用静态函数cancelRequestWithIndentity（cancelTOken:String ）传递你设置的cancelTOken .
<br/>
#####个性化请求:
```swift
let httpOption = [HttpClientOption.SavePath:myPath,HttpClientOption.TimeOut:NSNumber(int: 100)]
```
  在设置了全局Http请求环境后，对于有些请求你并不想让它遵守全局Http请求环境，那么你可以个性化该次请求，将个性化请求的参数放入字典中再传进去就行。具体有什么可以设置请参考结构体HttpClientOption
<br/>

#####使用用户名和密码:
有些网站需要登录凭证，也就是请求时带是用户名和密码，这样的话你既可以用全局静态方式来设置全局的用户名密码，也能在个性化请求中设置。（这个功能尚未测试）
#####更多的使用说明请参考HttpClientDemo
  
##联系方式 
有任何问题或者Bug请联系我 3421902@qq.com,我会很高兴为你解决问题
