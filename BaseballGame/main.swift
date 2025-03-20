/* 문제 접근
 9개 숫자를 랜덤으로 섞어 3자리 정답 생성
 게임을 시작하는 함수
 사용자의 입력을 받는 함수
 입력값이 3자리 숫자인지 확인하는 예외처리 함수
 입력값과 정답을 비교하는 함수
 횟수를 카운트 하는 함수.
 
 1. 게임시작함을 알리고 번호받기
 2. 번호 자릿수 확인(3자리인지)
 3. 횟수 카운트하기
 4. 번호가 맞으면 정답입니다 출력, 틀리면 비교해주기(숫자 자리 맞는지, 정답에 포함되어있는지)[조건 반복문 사용]
    ex)1스트라이크 1볼 입니다. 2번째 시도입니다
*/
import Foundation

let game = BaseballGame()
game.showMenu() // 게임 시작
