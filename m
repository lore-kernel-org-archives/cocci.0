From: remicles2@gmail.com (Remington Furman)
Date: Fri, 1 Dec 2017 10:09:19 -0800
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <1512151378.25588.20.camel@sipsolutions.net>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 <1512116859.25588.4.camel@sipsolutions.net>
 <5c6cb44c-9e19-8cf2-8946-a9c0e08c3974@gmail.com>
 <1512151378.25588.20.camel@sipsolutions.net>
Message-ID: <9df770ed-da27-95c6-6f8a-bafbfcbc90e9@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


On 12/01/2017 10:02 AM, Johannes Berg wrote:
> On Fri, 2017-12-01 at 09:57 -0800, Remington Furman wrote:
>> Ok, I've rebuilt with 1.0.4, and it applied genl-const.cocci just
>> fine.  But, later on my CPU was held at 100% for 29 minutes:
> Yeah, known issue. Give it more time - that particular patch is
> *really* slow. Yes, more than 29 minutes, on my system as well.
>
> What I can recommend is that you remove things from copy-list that you
> don't care about, e.g. bluetooth drivers if you don't need them,
> certain wifi drivers you don't need, etc. (before running gentree.py)
>
> johannes

Ok, that's great to know.? I will restart it.? I didn't know
about the copy list yet, that will be helpful.

Thank you again for your help.

-Remington
