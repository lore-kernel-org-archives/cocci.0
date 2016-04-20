From: mmarek@suse.com (Michal Marek)
Date: Wed, 20 Apr 2016 09:51:46 +0200
Subject: [Cocci] [PATCH] Coccinelle: setup_timer: Add space in front of
 parentheses
In-Reply-To: <alpine.DEB.2.10.1603201325011.2597@hadrien>
References: <1458451652-5933-1-git-send-email-vaishali.thakkar@oracle.com>
 <alpine.DEB.2.10.1603201325011.2597@hadrien>
Message-ID: <57173512.2050903@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 20.3.2016 v 13:25 Julia Lawall napsal(a):
> 
> 
> On Sun, 20 Mar 2016, Vaishali Thakkar wrote:
> 
>> Add space in front of the offending parentheses to silent the
>> parse error for older Coccinelle versions. This makes the rule
>> usable with all Coccinelle versions.
>>
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Applied to kbuild.git#misc.

Michal
