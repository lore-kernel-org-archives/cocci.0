From: mmarek@suse.com (Michal Marek)
Date: Mon, 26 Oct 2015 22:32:19 +0100
Subject: [Cocci] [PATCH 1/2] coccinelle: ifnullfree: improve and extend
	ifnullfree
In-Reply-To: <56236C9A.8060906@users.sourceforge.net>
References: <1445102605-22408-1-git-send-email-Julia.Lawall@lip6.fr>
 <56236C9A.8060906@users.sourceforge.net>
Message-ID: <562E9BE3.5080004@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 18.10.2015 v 11:55 SF Markus Elfring napsal(a):
>> Remove removal and re-addition of freeing functions.
> 
> I find such a wording confusing for a commit message.

It is also a bit confusing to use the same subject for two patches in a
series. How about

[PATCH 1/2] coccinelle: ifnullfree: Adjust tests to compare against NULL
[PATCH 2/2] coccinelle: ifnullfree: handle various destroy functions

?

Michal
