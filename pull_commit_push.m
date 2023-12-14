

clc;
clear;
close all;

repo = gitrepo;
pull(repo);
txt = input("Enter a message for this Git Commit: ","s");
commitDetails = commit(repo,Message=txt);
push(repo);


