From: keescook@chromium.org (Kees Cook)
Date: Tue, 10 Jan 2017 11:27:58 -0800
Subject: [Cocci] [RFC] coccicheck: add a test for repeat memory fetches
In-Reply-To: <CAGXu5j+Nk9r7K=FJe4v5b8mX_Fn411JMGks2sueyOFS2aTo1Ow@mail.gmail.com>
References: <20170109231323.GA89642@beast>
 <alpine.DEB.2.20.1701101927070.1981@hadrien>
 <CAGXu5j+Nk9r7K=FJe4v5b8mX_Fn411JMGks2sueyOFS2aTo1Ow@mail.gmail.com>
Message-ID: <CAGXu5jJinjK9CigN2TFggtpGPEnLsGmXOxKySWoFaoxioin-jQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jan 10, 2017 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jan 10, 2017 at 10:28 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>>> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2159
>>> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2257
>>> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2302
>>> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2342
>>> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2365
>>> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2406
>>> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2439
>>> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2491
>>
>> Do you want the above results?  They have the form:
>>
>> if (copy_from_user(&t, useraddr, sizeof(t)))
>>
>> My reasoning was that there could be no problem here, because the size is
>> the size of the destination structure.  It doesn't depend on user level data.
>
> They're likely false positives, but it does follow the pattern of
> reading the same userspace location twice:
>
>         if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
>                 return -EFAULT;
>
>         switch (cmd) {
>         case CHELSIO_SET_QSET_PARAMS:{
>                 int i;
>                 struct qset_params *q;
>                 struct ch_qset_params t;
>                 int q1 = pi->first_qset;
>                 int nqsets = pi->nqsets;
>
>                 if (!capable(CAP_NET_ADMIN))
>                         return -EPERM;
>                 if (copy_from_user(&t, useraddr, sizeof(t)))
>                         return -EFAULT;
>
> If there is any logic that examines cmd (u32) and operates on t
> (struct ch_qset_params), there could be a flaw. It doesn't look like
> it here, but a "correct" version of this would be:
>
>                 if (copy_from_user(&t, useraddr, sizeof(t)))
>                         return -EFAULT;
>                 t.cmd = cmd;

Errr, no. Think-o. Should be "if (t.cmd != cmd) { freak out }"...

-Kees

-- 
Kees Cook
Nexus Security
