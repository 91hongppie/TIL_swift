# Dicee

주사위 놀이 앱을 만들어보자.



## Main.storyboard

1. Assets.xcassets에 사용할 이미지들을 추가해준다. 주사위 1~6, DiceeLogo, Background, AppIcon와 앱을 킬 때 뜰 화면과 로고를 추가해준다.
2. 앱을 킬 때 뜨는 화면은 LaunchScreen.storyboard에 만들어주면 된다.
3. ImageView에 background이미지를 넣어주고 SafeArea까지 늘려준다.
4. ImageView를 하나 더 추가하여 DiceeLogo를 지정해준다.
5. ImageView를 두개 더 추가하여 주사위 이미지를 지정해준다.
6. Button을 하나 추가한다.

## ViewController.swift

1. Main.storyboard에서 주사위 이미지를 control + 클릭하여 IBOutlet으로 가져온다.

2. 버튼을 IBAction으로 가져와서 함수를 만든다.

3. 함수 안에 diceArray를 만들어 주사위 이미지를 전부 넣어준다.

4. 배열에서 랜덤으로 요소를 가져오는 방법 

   ```swift
   diceImageView1.image = diceArray.randomElement()
   ```

   ```swift
   diceImageView2.image = diceArray[Int.random(in: 0...5)]
   ```

   
