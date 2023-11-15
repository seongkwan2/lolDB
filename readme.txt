팀프로젝트 git 사용방법

1. 각자 만든것 각자의 브런치에서
   -git add --all
   -git commit -m "설명"
   -git push -u origin 자신의 브런치명

2. 마스터로 이동후 git merge 자신의 브런치명
   -git add --all
   -git commit -m "설명"
   -git push -u origin 자신의 브런치명

받을때
1. git checkout master에서 github페이지에있는 데이터들을 git pull로 받음

2. git merge sk

3. 겹치는것들 수정 저장

4. add , commit, push

ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
1. git checkout sk (내 브런치 최신화 작업)

2. git merge master (마스터의 데이터를 가져옴)

3. git push -u origin sk (최신화 된 정보를 push)
