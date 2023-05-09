###### tags: `README`

# 📚 Digital Library

## 프로젝트 소개
환경부_디지털도서관 소장자료 목록을 받아와 GridView 로 표현한 앱 입니다. 

## 📑 목차

- [🔑 핵심기술](#🔑-핵심기술)
- [📱 실행화면](#📱-실행화면)
- [🔭 프로젝트 구조](#🔭-프로젝트-구조)
- [⚙️ 적용한 기술](#⚙️-적용한-기술)

## 🔑 핵심기술
- **`UI 구현`**
    - SwiftUI
    - NavigationLink
- **`비동기처리`**
    - async-await
    - DispatchQueue
- **`라이브러리`**
    - LWBNetwork
<br>
    
## 📱 실행화면
    
| 홈화면|상세화면|
|:---:|:---:|
|<img src="https://hackmd.io/_uploads/H1g1pIPVn.png" width="200">|<img src="https://hackmd.io/_uploads/Hyb628DV3.png" width="200">|

<br>
    
## 🔭 프로젝트 구조

- 간단한 프로젝트기에 아키텍쳐를 적용하지 않고, Model 과 View 로만 프로젝트를 구성했습니다. 
    
## ⚙️ 적용한 기술

### ✅ LWBNetwork
- 직접 만든 네트워킹 라이브러리 입니다. 자주 사용하던 네트워킹 코드를 추상화 하여 라이브러리화 했습니다.
- `async-await` 으로 네트워크 비동기 처리가 되어있어, 이 라이브러리를 사용하는 프로젝트에서도 `async-await` 으로 비동기 처리를 해주어야 합니다. 

### ✅ 당겨서 다음 페이지 불러오기
- 데이터 20개 씩 페이징을 구현하는 목적이 있었습니다. 
- 스크롤이 스크롤뷰 최하단에 닿은 상태에서, 사용자가 더 아래를 보기 위해 당겼을 때를 인식하기 위해 `PreferenceKey` 를 이용하여 ScrollOffset 상태를 구독했습니다.
- 지정한 offSet 값(100) 을 넘게 당기면 다음 데이터를 불러오도록 설정 했습니다.
```swift
.onPreferenceChange(ScrollOffsetKey.self) { value in
    let atBottomValue = DeviceSize.height - CGFloat(160)
    let scrollOffset = atBottomValue - value

    if scrollOffset > 100 {
        guard shouldFetchMoreBooks == false else { return }
        shouldFetchMoreBooks = true
    }
}
```

![](https://hackmd.io/_uploads/rJWZgwwV3.gif)

### ✅ ToastMessage
- 마지막 페이지에 도달했을 때, 알림을 주기 위해 `ToastMessage`를 구현했습니다. 
![](https://hackmd.io/_uploads/B1rclwDN2.gif)

### ✅ Sticky Header
- 사용자에게 익숙한 UI를 제공하기 위해 상세보기에서 `Sticky Header`를 구현했습니다.
![](https://hackmd.io/_uploads/ryDW1PwE3.gif)

### ✅ LightMode / DarkMode
- 라이트모드와 다크모드 두 모드에서 색감차이를 보이지 않도록 `Semantic Color`를 이용했습니다.  

| 홈화면|상세화면|
|:---:|:---:|
|<img src="https://hackmd.io/_uploads/B1f5WPDVn.png" width="200">|<img src="https://hackmd.io/_uploads/ryb8-Pv4n.png" width="200">|


<br>

## ⚠️ Trouble Shooting

### 🛠 이미지 크기의 다양성
- 책 표지 이미지가 없는 것에 대해서는 `PlaceholderImage` 를 만들어 적용 해주었습니다.
- 책 표지 이미지가 있어도 크기가 다양해서 width 값만 통일 시켜주고 최대 높이값에 맞춰 셀 높이를 형성했습니다.  

### 🛠 async메서드 사용시 data-race 문제 발생 
- 사용자가 스크롤을 지정값(100) 이상 당겼을 때, 다음 데이터를 불러오도록 설정했는데, 100을 넘은 순간이 여러번 발행 되어 수많은 요청이 동시에 발생되어 다음페이지 데이터가 아닌 같은 페이지 데이터를 중복해서 불러오는 현상이 있었습니다. 
- 뮤텍스락의 역할을 해줄 `Bool` 타입 변수를 이용해서 한번의 당김에 한번의 요청만 일어나게 만들고, `asyncAfter` 메서드를 사용해서 `Bool` 타입 변수는 1초뒤에 `toggle()` 이 되도록 만들어 중복요청을 막아주었습니다. 



## 🔗 References
- [Apple Docs - SwiftUI](https://developer.apple.com/documentation/swiftui/#essentials)
- [환경부_디지털도서관 소장목록 API](https://www.data.go.kr/data/3041077/openapi.do)
