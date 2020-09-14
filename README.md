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

## 20.09.12
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

