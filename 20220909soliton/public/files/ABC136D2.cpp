/*
AC
*/
#include<string>
#include<algorithm>
#include<iostream>
#include<vector>
using namespace std;


int main(){
    string S;
    cin>>S;
    int n=S.size();
    vector<vector<int>> dp(34,vector<int>(n));
    for(int i=0;i<n;i++){
        if(S[i]=='L') dp[0][i]=i-1;//i番目は i-1にいく
        else dp[0][i]=i+1;
    }

    for(int p=0;p<=32;p++){
        for(int j=0;j<n;j++){
        dp[p+1][j]=dp[p][dp[p][j]];
        }
    }

    vector<int> ans(n,0);
    for(int i=0;i<n;i++){
        ans[dp[33][i]]++;
    }


    for(int i=0;i<n;i++){
        cout<<ans[i]<<(i==n-1?'\n':' ');
    }
}