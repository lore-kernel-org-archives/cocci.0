From: keescook@chromium.org (Kees Cook)
Date: Tue, 10 Jan 2017 12:04:14 -0800
Subject: [Cocci] [RFC] coccicheck: add a test for repeat memory fetches
In-Reply-To: <alpine.DEB.2.20.1701102028300.1981@hadrien>
References: <20170109231323.GA89642@beast>
 <alpine.DEB.2.20.1701101927070.1981@hadrien>
 <CAGXu5j+Nk9r7K=FJe4v5b8mX_Fn411JMGks2sueyOFS2aTo1Ow@mail.gmail.com>
 <alpine.DEB.2.20.1701102028300.1981@hadrien>
Message-ID: <CAGXu5jLT8w6bK8SC4=Wne1BtfPsALiBSeyr6OK_jsCfaiJ+KRg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jan 10, 2017 at 11:30 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Tue, 10 Jan 2017, Kees Cook wrote:
>
>> On Tue, Jan 10, 2017 at 10:28 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2159
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2257
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2302
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2342
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2365
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2406
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2439
>> >> +./drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:2491
>> >
>> > Do you want the above results?  They have the form:
>> >
>> > if (copy_from_user(&t, useraddr, sizeof(t)))
>> >
>> > My reasoning was that there could be no problem here, because the size is
>> > the size of the destination structure.  It doesn't depend on user level data.
>>
>> They're likely false positives, but it does follow the pattern of
>> reading the same userspace location twice:
>>
>>         if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
>>                 return -EFAULT;
>>
>>         switch (cmd) {
>>         case CHELSIO_SET_QSET_PARAMS:{
>>                 int i;
>>                 struct qset_params *q;
>>                 struct ch_qset_params t;
>>                 int q1 = pi->first_qset;
>>                 int nqsets = pi->nqsets;
>>
>>                 if (!capable(CAP_NET_ADMIN))
>>                         return -EPERM;
>>                 if (copy_from_user(&t, useraddr, sizeof(t)))
>>                         return -EFAULT;
>>
>> If there is any logic that examines cmd (u32) and operates on t
>> (struct ch_qset_params), there could be a flaw. It doesn't look like
>> it here, but a "correct" version of this would be:
>>
>>                 if (copy_from_user(&t, useraddr, sizeof(t)))
>>                         return -EFAULT;
>>                 t.cmd = cmd;
>
> OK, I'm fine with putting them all back.
>
> For another issue, what about code like the following:
>
>         if (copy_from_user(&u_cmd, arg, sizeof(u_cmd)))
>                 return -EFAULT;
>
>         if ((u_cmd.outsize > EC_MAX_MSG_BYTES) ||
>             (u_cmd.insize > EC_MAX_MSG_BYTES))
>                 return -EINVAL;
>
>         s_cmd = kmalloc(sizeof(*s_cmd) + max(u_cmd.outsize, u_cmd.insize),
>                         GFP_KERNEL);
>         if (!s_cmd)
>                 return -ENOMEM;
>
>         if (copy_from_user(s_cmd, arg, sizeof(*s_cmd) + u_cmd.outsize)) {
>                 ret = -EFAULT;
>                 goto exit;
>         }
>
> It doesn't actually test sizeof(*s_cmd) + u_cmd.outsize, but it does test
> u_cmd.outsize > EC_MAX_MSG_BYTES, and presumably that test accounts for
> the extra sizeof(*s_cmd) value.

This is also bad since s_cmd now contains possibly new values for
outsize and insize, even though the old outsize was allocated. e.g.
past-end-of-buffer reads could happen for:

arg->outsize = 4
copy_from_user(&u_cmd, arg, ...)
s_cmd = kmalloc(... + 4)
arg->outsize = 1024
copy_from_user(s_cmd, arg, ...)

now s_cmd has only the 4 bytes allocated but anything operating on the
new outsize will expect 1024. This code needs the same sanity check:

if (s_cmd->outsize != u_cmd.outsize || s_cmd->insize != u_cmd.insize) {
    ret = -EINVAL;
    goto exit;
}

-Kees

-- 
Kees Cook
Nexus Security
