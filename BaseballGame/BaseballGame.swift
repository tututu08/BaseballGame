//
//  File.swift
//  BaseballGame
//
//  Created by 강성훈 on 3/17/25.
//
import Foundation

class  BaseballGame {
    // 정답으로 사용될 3자리 랜덤 숫자를 저장할 배열
    var quizNum: [Int] = []
    
    //0부터 9까지 서로 다른 3개의 숫자를 랜덤으로 선택하는 함수
    func makeQuizNum() {
        // quizNum 배열을 비워서 새로운 게임을 시작할 때 기존 데이터를 초기화
        quizNum = []
        
        // quizNum 배열의 개수가 3개가 될 때까지 반복
        while quizNum.count < 3 {
            // 0부터 9까지의 랜덤한 숫자를 생성, 첫번째 자리는 0이면 안됌, 삼항 연산자 활용.
            let number = quizNum.isEmpty ? Int.random(in: 1...9) : Int.random(in: 0...9)
           
            // 중복된 숫자가 없는 경우에만 배열에 추가
            if !quizNum.contains(number) {
                quizNum.append(number)
            }
        }
        // 디버깅용
        print("정답 : \(quizNum)")
    }
    
    //게임을 시작하는 함수
    func start() {
        // 랜덤한 정답을 생성
        makeQuizNum()
        print(" 숫자야구 게임을 시작합니다. 3자리의 숫자를 입력하세요.\n", "<사용할 수 있는 숫자: 0~9 / 중복허용 X / 0이 첫번째 자리에 올 수 없음 / 예시 : 123>")
        
        // 사용자가 정답을 맞출 때까지 반복 실행(무한반복문 while true사용)
        while true {
            // 사용자로부터 입력을 받음
            let userGuess = getUserInput()
            
            // 입력값과 정답을 비교하여 스트라이크와 볼 개수를 계산
            let (strike, ball) = makeHint(userGuess)
            
            // 3스트라이크인 경우 정답을 맞췄으므로 게임 종료
            if strike == 3 {
                print("정답입니다. 게임을 종료하고 메인메뉴로 돌아갑니다.\n")
                return //`return`을 사용하여 게임을 종료하고 메인 메뉴로 돌아감
            }
            // 스트라이크와 볼이 모두 0이면 "Nothing" 출력
            else if strike == 0 && ball == 0 {
                print("Nothing")
            }
            // 그 외에는 스트라이크와 볼 개수를 출력
            else {
                print("\(strike) 스트라이크 \(ball) 볼")
            }
        }
    }
    
    //사용자 입력을 받아 검증하는 함수
    func getUserInput() -> [Int] {
        // 올바른 입력값을 받을 때까지 반복(무한반복문 while true사용)
        while true { //무한 반복문,
            print("숫자를 입력하세요: ", terminator: "")
            
            // 사용자가 입력한 문자열을 읽고 검증 함수(validateInput)에서 검증
            if let input = readLine(), let validatedInput = validateInput(input) {
                return validatedInput // 검증된 유효한 입력값 반환
            }
            
            // 잘못된 입력값일 경우 경고 메시지를 출력하고 다시 입력 받도록 반복
            print("올바르지 않은 입력값입니다, 조건을 확인하고 다시 입력해주세요!")
        }
    }
    
    //입력값이 올바른지 검증하는 함수 (세 자리 숫자, 중복 없음, 0이 첫번째 자리에 오지 않게)
    func validateInput(_ input: String) -> [Int]? {
        //compactMap { Int(String($0)) } → 각 문자를 문자열 → 정수(Int) 변환
        let digits = Array(input).compactMap { Int(String($0)) }
        // 중복된 숫자가 있는지 확인하기 위해 Set 사용
        let uniqueDigits = Set(digits)
        
        // 입력값이 3자리이고, 중복이 없으며, 0이 포함되지 않은 경우에만 유효한 값으로 인정
        if digits.count == 3 && uniqueDigits.count == 3 && digits[0] != 0 {
            return digits // 유효한 입력값이면 변환된 정수 배열 반환
        }
        return nil // 잘못된 입력값이면 nil 반환
    }
    
    //입력값과 정답을 비교하여 스트라이크와 볼 개수를 계산하는 함수
    func makeHint(_ guess: [Int]) -> (Int, Int) {
        var strike = 0 // 스트라이크 개수 저장
        var ball = 0 // 볼 개수 저장
        
        // 입력값과 정답을 비교하여 스트라이크와 볼 개수 확인
        for i in 0..<3 {
            // 같은 위치에 같은 숫자가 있다면 스트라이크 증가
            if guess[i] == quizNum[i] {
                strike += 1
            }
            // 정답에 포함된 숫자지만 위치가 다르면 볼 증가
            else if quizNum.contains(guess[i]) {
                ball += 1
            }
        }
        return (strike, ball) // 스트라이크와 볼 개수를 튜플로 반환
    }
}
// 게임 시작 전 메인 메뉴를 보여주는 함수
func showMenu() {
    while true { // 프로그램이 종료되기 전까지 반복 실행
        print("\n원하시는 번호를 입력해주세요.")
        print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")

        print("입력: ", terminator: "")
        if let input = readLine(), let choice = Int(input) {
            switch choice {
            case 1:
                let game = BaseballGame()
                game.start() // 게임 시작
            case 2:
                print("게임 기록 보기 기능은 아직 구현되지 않았습니다.")
            case 3:
                print("프로그램을 종료합니다.")
                return // 프로그램 종료
            default:
                print("잘못된 입력입니다. 1~3 사이의 숫자를 입력해주세요.")
            }
        } else {
            print("숫자로 입력해주세요.")
        }
    }
}
