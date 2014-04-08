From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 8 Apr 2014 15:40:15 +0200 (CEST)
Subject: [Cocci] double_lock.cocci extremely slow for multiple mutex
 locks check
In-Reply-To: <CAH3Oq6SOduFvyppbXFpaJU09ztx7=36L26fHRbw1cCZM2SBmQQ@mail.gmail.com>
References: <CAH3Oq6SOduFvyppbXFpaJU09ztx7=36L26fHRbw1cCZM2SBmQQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1404081539310.2185@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 8 Apr 2014, Ning Jiang wrote:

> Hi,
> I met a case when checking my driver by coccicheck. It can be illustrated by
> the simplified test-cocci.c.
>
> #include <linux/mutex.h>
>
> static DEFINE_MUTEX(test_lock);
>
> int test_cond;
> int cmd;
> int type;
> int ret;
>
> int test_cocci_func(void)
> {
> if (ret == 1)
> return -1;
>
> if (!test_cond) {
> switch (cmd) {
> case 0:
> mutex_lock(&test_lock);
> mutex_unlock(&test_lock);
> break;
> }
> }
>
> if (ret < 0)
> return ret;
>
> if (test_cond) {
> switch (cmd) {
> case 0:
> if (type == 1) {
> mutex_lock(&test_lock);
> mutex_unlock(&test_lock);
> } else if (type == 2) {
> mutex_lock(&test_lock);
> mutex_unlock(&test_lock);
> }
> break;
> case 1:
> if (type == 1) {
> mutex_lock(&test_lock);
> mutex_unlock(&test_lock);
> } else {
> mutex_lock(&test_lock);
> mutex_unlock(&test_lock);
> }
> break;
> }
> }
>
> return ret;
> }
>
> I run the coccicheck like this:
> time make coccicheck V=1 MODE=report M=test-cocci
> COCCI=scripts/coccinelle/locks/double_lock.cocci 1>test-cocci-result 2>&1
>
> It gives the following output:
> real ? ?2m1.676s
> user ? ?2m0.904s
> sys ? ? 0m0.160s
>
> The strange thing is that after I removed the code at the beginning of the
> function:
> if (ret == 1)
> return -1;
>
> The test result will be much better:
> real ? ?0m0.896s
> user ? ?0m0.500s
> sys ? ? 0m0.148s
>
> Could you please check the issue?

I will check it.  But there are numerous problems with switch, so that
might be the source of the problem.

julia
