%Name:        Isaac Nakone, Denis Vasilyev, Harry Rowton, Jingya Liu
%Date:        15/12/2023
%Description: Code for github stuff.

clc;
clear;
close all;

repo = gitrepo;
pull(repo);
txt = input("Enter a message for this Git Commit: ","s");
commitDetails = commit(repo,Message=txt);
push(repo);




