-- Ctrl+Enter / F9 : 실행 단축키

alter session set "_ORACLE_SCRIPT"=true;    -- userid ## 붙여야 하는 것을 생략가능

create user ora_user identified by 1111;    -- ora_user, 1111 계정생성

grant connect, resource, dba to ora_user;   -- 접속권한, 자원할당, db명령어 사용권한 할당

create user ora_user2 identified by 1111;

grant connect, resource, dba to ora_user2;