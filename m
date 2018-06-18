From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 18 Jun 2018 22:47:49 +0900
Subject: [Cocci] [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <alpine.DEB.2.20.1806150705540.2565@hadrien>
References: <1504258820-2122-1-git-send-email-elena.reshetova@intel.com>
 <CAGXu5jK-6fNvaEiX1Wvp98BKv+uF17KdFyPQKi5hgE-Jz3-+Tg@mail.gmail.com>
 <alpine.DEB.2.20.1806150705540.2565@hadrien>
Message-ID: <CAK7LNAT=7E0HFd+MM92VcNdA1i6AME6qyFA9sN-2dabibxkiJg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2018-06-15 14:06 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
>
>
> On Thu, 14 Jun 2018, Kees Cook wrote:
>
>> On Fri, Sep 1, 2017 at 2:40 AM, Elena Reshetova
>> <elena.reshetova@intel.com> wrote:
>> > atomic_as_refcounter.cocci script allows detecting
>> > cases when refcount_t type and API should be used
>> > instead of atomic_t.
>> >
>> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
>> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>
>> Oops, I think this got lost. Who can take this patch? I thought Julia
>> ran the scripts/coccinelle/ tree, but looking at git log, it looks
>> more like it's Masahiro? Either way, let's get this in the tree. Who
>> can take it?
>
> Masahiro takes patches.
>
> julia


Somehow I missed this one.
Now, applied to linux-kbuild.  Thanks for the reminder.

(If Julia hosted a git repository, that would be better, though.)


-- 
Best Regards
Masahiro Yamada
