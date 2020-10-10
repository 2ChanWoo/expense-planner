# expense_planner

expense planner app

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

##20.10.10
위젯은 고유의 Context를 가지고 있다. Context는 어디에나 있으며 모든 위젯에는 Context가 연결되어 있다.

위젯 층간에 인수를 사용하고 ThemeData와 MediaQuery Data를 수동으로 전달하는 것은 매우 번거로운 일일 것.
따라서, **IngeritedWidget** 사용. (-> Context가 이곳에서 관리된다.)


####When to use Key?

대부분의 경우 키가 필요 없지만,
동일한 상태의 동일 위젯으로 구성된 Collection을 재정렬 하거나, 추가/삭제 하는 등의 작업을 한다면, 키가 필요로 될 수 있다.!

<https://www.youtube.com/watch?v=kn0EOS-ZiIc>

<https://nsinc.tistory.com/214>

####Key를 어디에 위치시켜야 합니까??
요약 : 유지해야 하는 상태 정보가 있는 위젯 트리의 **최상단**에 추가해야 합니다.!

##10.10.08

####App LifeCycle

- Inactive : 비활성화 상태.
앱이 백그라운드에서 실행되고 있지 않음. 비활성 상태이고, 사용자가 볼 수 없으며, 사용자 입력을 수신할수 없는 상태.
아직 메모리에서 완전히 지워지지는 않았지만 도달할 수는 있는 상태??

- Paused : 중지상태.
하지만 지금은 앱이 보이지 않을 때 이고 백그라운드에서 실행중일 때.
마지막 순간 청소를 하기 위해? 서버 연결 해제등 작업을 수행할 수 있음??

- Resumed : 다시 보이고 사용자 입력에 응답하는 경우.
이 때는 서버에 대한 실시간 연결을 다시 설정하고 원하는지 확인하는 것이 좋습니다?

- Suspending : 앱이 일시 중단되려고 할 때 도달한 상태? 거의 사라졌지만 여전히 있는 상태?
운영 체제에 의해 지워지려고 할 때, 메모리에서 제거 하려고 할 때

addObserver 에서 라이프사이클 상태가 바뀔 때마다 Observer에 가서
didChangeAppLifeCycleState()  메소드를 호출한다?

홈키를 눌러서 앱을 백그라운드 동작시키면 inactive(비활성화) – pause(중지)
다시 앱을 실행시키면 resumed(깨어남)
뒤로가기 키를 눌러 종료시키면 비활성화-중지-detached???
강의 말로는 suspending 이 되어야한다는데..
(++강의에서도 paused까지만 나오고 안나오구, 내 에뮬에서 강제종료시키면 암것두 안나옴.
강의자 말로는 앱이 이미 꺼져서 해당 print문에 접근을 못하는듯 하다고 한다.)

##20.10.05

####Widget Tree & Element Tree
Element Tree는 Widget Tree를 기반으로 플러터가 자동으로 만들고, **위젯을 실제 렌더링된 객체에 연결한다.**

##20.10.04

- MediaQuery.of(context).viewInsets.bottom
키보드가 나왔을 때, 그 높이를 계산하여 해당 높이만큼 패딩을 줄 수 있음.

- 가로모드, 세로모드 구분이아니라~~ 가로의 길이로만 계싼~!  **MediaQuery.of(ctx).size.width**

icon과 label이 추가된 Flatbotton.icon

## 20.10.01
- Distinguish landscape mode and portrait mode
- use MediaQuery, textScaleFactor, LayoutBuilder
주석처리 했지만, main() 함수에서 세로모드로 고정시킬 수 있는 명령어를 처리해봤고

MediaQuery, textScaleFactor, LayoutBuilder 를 사용해서

각 위젯들의 크기 비율을 핸드폰 크기에 따라 맞춰주었다.

### **MediaQuery를 이용해서 100% 크기를 맞추면 초과됨.!**

####  ㄴ> 앱바와, 상태표시줄의 높이를 제거해야 사용할 수 있는 크기 100%를 가질 수 있다.!!!!

textScaleFactor : 사용 화면의 크기에 따라 글씨 크기를 조정할 수 있다.

LayoutBuilder : builder 의 2번째 매개변수로 상위 위젯의 최대크기에 따라 크기 조정 가능.

## 20.09.14
- add DatePicker

use with Future.then

Then이라고 해서 순서대로 되는 것이 아님.

Then이 여러차례 되어있으면 (.then(~).then(~)) 첫번쨰 then의 내용이 끝나야 다음으로 넘어가는 것이 아님.

두번째 then이 먼저 끝날 수 있으면, 두번째 부터 처리된 후 첫번째가 처리될 수 있음.


## 20.09.12
- FractionallySizedBox 적용

Container와 겹쳐서 사용하는 FractionallySizedBox 을 적용시켜, 그래프 차트처럼 보이게 적용시킴.
**주의** _FractionallySizedBox 에서의 heightFactor 가 NaN인 경우에 Error 발생함._

- chart에서의 text가, main-textTheme 의 light-dark 할때 반대로 되는걸까...? 적용시키지도 않았는데,,

- **Shared Preferences** 값을 기기 저장소에 저장. 앱을 껏다 켜도 설정값 유지되게 하는 기능!

- Flexible – fit: FlexFit.tight 를 사용하면, 공간을 엄격하게 관리.!

mainAxisAlignment 와 같은 기능이지만, mainAxisAlignment는 위젯의 크기가 달라지면 균형이 무너지지.

Flexible 은 하위 위젯의 크기를 제한하는 힘을 가지고 있구나.!

++flex 사용가능하고, FlexFit.tight 을 디폴트로 가지고 있는 위젯 :: Expanded


- List.fold() , List.reduce()

## 20.09.06
- user_transactions 을 삭제하고,
입력 부분을 showModalBottomSheet 로 교체.
PrimarySwatch 와 accentColor 설정.

- 머테리얼 디자인 중, primary 색상보다 accentColor 가 우선되는 것들이 있다.

그 중 하나가 Floating button이다

이 경우, accentColor가 있으면 해당 색상으로, 없다면 하위설정인 primary 색상이 적용된다.

- PrimarySwatch 는 PrimaryColor와 다르게, 색상을 정할 때 음영을 설정할 수 있다.!

다른 차이점은 아직 잘..ㅎ  (아,! 색상도 더욱 다양한 듯 하다)

- 93. 강의보면, 5:43 에 뭐가 더 많이 있는데 나는 건너띄었는데,,

