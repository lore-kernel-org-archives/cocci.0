From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 1 Feb 2017 16:38:29 -0600
Subject: [Cocci] Hunt for array users of roc_dointvec()
In-Reply-To: <alpine.DEB.2.20.1702012334030.2021@hadrien>
References: <20170201203531.GI24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012259050.2021@hadrien>
 <20170201220507.GK24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012313470.2021@hadrien>
 <20170201223133.GL24047@wotan.suse.de>
 <alpine.DEB.2.20.1702012334030.2021@hadrien>
Message-ID: <CAB=NE6W5Booei9rqkMZLs+jpUzfh7m+rF3xFROUaZnSQ2Xu5bA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Feb 1, 2017 at 4:34 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Wed, 1 Feb 2017, Luis R. Rodriguez wrote:
>> Ah you are right, but it then goes ahead and uses it directly:
>>
>> ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
>>
>> So I would need to capture this use in another rule. I can do
>> that later once I iron out the first part, which is to first
>> hunt for non maxlen = sizeof(unsigned int).
>
> Do you require that there is exactly one element in the arrays?

Well my eventual hunt is for all array users. So I'm starting off by
first looking for all simple setups with non-array cases, and then
giving context for those that are not singular. So eventually I will
write a rule that will show the entries which do not have

(
maxelen = sizeof(int),
|
maxlen =  sizeof(unsigned int).,
)

I figure this list should be small enough to inspect with one's eyeballs then.

  Luis
