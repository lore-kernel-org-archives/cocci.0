From: andi@firstfloor.org (Andi Kleen)
Date: Fri, 14 Feb 2014 07:35:03 -0800
Subject: [Cocci] Patch macros
Message-ID: <87eh35emhk.fsf@tassilo.jf.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


Hi,

I was trying to replace static asmlinkage with static. However
it always gives a cocci parsing error. I assume the problem is that
asmlinkage is really a macro (for __attribute__((visible)) in
my case). How to handle this in cocci?

Thanks,

-Andi

@@
type T;
@@
- static asmlinkage T
+ static T


-- 
ak at linux.intel.com -- Speaking for myself only
