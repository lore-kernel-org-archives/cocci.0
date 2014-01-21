From: linjia@ruijie.com.cn (=?gb2312?B?wda8ziizzLb+ILij1t0p?=)
Date: Tue, 21 Jan 2014 09:11:44 +0000
Subject: [Cocci] infinitly loop in spatch?
In-Reply-To: <alpine.DEB.2.02.1401210848170.2002@localhost6.localdomain6>
References: <041CF35939B5534D851F16C30DD0B8CF727F4841@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021014460.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F488A@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021024400.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F5C4F@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401021111560.2182@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F5CA5@fzex.ruijie.com.cn>
 <alpine.DEB.2.10.1401021418020.2088@hadrien>
 <041CF35939B5534D851F16C30DD0B8CF727F5D5A@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401030705560.2150@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F89C4@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210433490.2092@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8A3E@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210730200.2002@localhost6.localdomain6>
 <041CF35939B5534D851F16C30DD0B8CF727F8ACB@fzex.ruijie.com.cn>
 <041CF35939B5534D851F16C30DD0B8CF727F8AEF@fzex.ruijie.com.cn>
 <alpine.DEB.2.02.1401210848170.2002@localhost6.localdomain6>
Message-ID: <041CF35939B5534D851F16C30DD0B8CF727F8BD2@fzex.ruijie.com.cn>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When I use spatch to scan some file, I found it may loop sometimes, did anyone encounter too?

If using -debug,  it show pause at 'bind' step 

-----------------------------------------------------------------------
HANDLING: /root/windows/ok_file.c
-----------------------------------------------------------------------
let's go
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
rule starting on line 1 = 
-----------------------------------------------------------------------
dependencies for rule rule starting on line 1 satisfied:
binding in = []
binding relevant in = []
-----------------------------------------------------------------------
proto for rule starting on line 1 = 
-----------------------------------------------------------------------
dependencies for rule proto for rule starting on line 1 not satisfied:
rule starting on line 1 not satisfied
binding in environment = []
-----------------------------------------------------------------------
Finished
-----------------------------------------------------------------------
HANDLING: /root/loop_file.c
-----------------------------------------------------------------------
let's go
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
rule starting on line 1 = 
-----------------------------------------------------------------------
dependencies for rule rule starting on line 1 satisfied:
binding in = []
binding relevant in = []  <---  step here, then nothing more output.....     :(
