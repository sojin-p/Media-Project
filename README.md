<img src="https://github.com/sojin-p/GoorumMode/assets/140357450/42691454-9458-495c-a128-7d0876513eb9" width="150" height="150"/>  

# MOVIE UP - 한눈에 보는 영화 정보
![iPhone Screenshot](https://github.com/sojin-p/MovieUp/assets/140357450/f3a16d79-2941-455d-8eae-c73ef12bfa39)  

<Br>

## 목차
:link: [개발 기간 및 환경](#개발-기간-및-환경)  
:link: [사용 기술 및 라이브러리](#사용-기술-및-라이브러리)  
:link: [핵심 기능](#핵심-기능)  
:link: [고려했던 사항](#고려했던-사항)  
:link: [트러블 슈팅](#트러블-슈팅)  
:link: [회고](#회고)  

<Br>

## 개발 기간 및 환경
- 개인 프로젝트
- 23.08.11 ~ 23.08.29
- Xcode 14.3.1 / Swfit 5.9 / iOS 15+
 
<Br>

## 사용 기술 및 라이브러리
| Kind         | Stack                                        |
| ------------ | -------------------------------------------- |
| 아키텍쳐     | `MVC`                                          |
| 프레임워크   | `Foundation` `UIKit` `WebKit`                   |
| 라이브러리   | `SnapKit` `Alamofire` `Kingfisher` `SwiftyJSON` |
| 의존성관리   | `Swift Package Manager`                         |
| ETC.         | `CodeBasedUI` `Storyboard`                   |  

<Br>

## 핵심 기능
- 영화 목록 : DispatchGroup을 활용하여 TMDB API 4개를 동시에 로드
- 줄거리, Cast 목록 : TMDB API를 Alamofire와 Router 패턴을 활용하여 구현
- WebKit을 활용한 미리보기 영상
- Prefetch 메서드 기반의 Pagination

<Br>

## 고려했던 사항
   - **APIManager** 파일로 네트워크 통신을 **모듈화**하여 **유지 보수성 향상**
   - 여러 API 메서드를 **제네릭**으로 추상화하여 **중복 코드 최소화**
   - **Rauter 패턴** 도입으로 네트워크 통신을 구조화하여 **유연성 및 유지 보수성 향상**
   - **DispatchGroup**으로 비동기 작업을 효율적으로 관리하여 **가독성 및 유지 보수성 향상**
   - Network Error를 **열거형**으로 정의하여 **안정성 및 가독성 향상**
   - **Codable 및 CodingKey** 프로토콜로 데이터 모델 직렬화 및 역직렬화하여 **안정성 및 유지 보수성 향상**
   - **BaseViewController**로 공통 로직과 UI를 효율적으로 관리
   -  ReusableViewProtocol을 채택하여 재사용 셀 및 뷰 컨트롤러의  **identifier**를 효율적으로 관리

<Br>

## 트러블 슈팅
1. Router 패턴으로 변경 후 서버 통신이 되지 않는 이슈
   - **원인** : 쿼리 스트링 `?` 문자가 `%3F`로 인코딩 되어 발생
   - **해결** : 인증 키를 query 연산 프로퍼티로 이동하여 해결
```swift
private var path: String {
        switch self {
        case .trending(let filter):
            //return "trending/\(filter.string)/day?=api_key\(APIKey.tmdbKey)"
            return "trending/\(filter.string)/day" //변경 후
```
```swift
private var query: [String: String] {
        return [
            "api_key": APIKey.tmdbKey,
            "language": "ko"
        ]
    }
```
<Br>

2. TableView HeaderView 안에 있는 버튼과 이미지가 클릭되지 않는 이슈
   - **원인** : HeaderView를 UIImageView로 설정하여 발생
   - **해결** : UIView로 변경하여 해결  
   
```swift
let headerView = {
        //let view = UIImageView()
        let view = UIView() //변경 후
        return view
    }()
```

<Br>

## 회고

