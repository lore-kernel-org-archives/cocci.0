From: keescook@chromium.org (Kees Cook)
Date: Tue, 10 Jan 2017 16:04:06 -0800
Subject: [Cocci] [RFC] coccicheck: add a test for repeat memory fetches
In-Reply-To: <alpine.DEB.2.20.1701102207590.1981@hadrien>
References: <20170109231323.GA89642@beast>
 <alpine.DEB.2.20.1701101927070.1981@hadrien>
 <CAGXu5j+Nk9r7K=FJe4v5b8mX_Fn411JMGks2sueyOFS2aTo1Ow@mail.gmail.com>
 <alpine.DEB.2.20.1701102028300.1981@hadrien>
 <CAGXu5jLT8w6bK8SC4=Wne1BtfPsALiBSeyr6OK_jsCfaiJ+KRg@mail.gmail.com>
 <alpine.DEB.2.20.1701102207590.1981@hadrien>
Message-ID: <CAGXu5jJ55j1r3H2NP8P4Tv4kqu+DZbj+Q6eor6mUcX8eRj4NTQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jan 10, 2017 at 1:14 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> OK, I have the impression that what you are looking for is the following,
> that currently does not seem to work well. Still maybe it gives an idea.
>
> The basic pattern is the following sequence:
>
> 1. copy_from_user
> 2. test on a field of the copied value
> 3. another copy_from_user
> 4. a use of the same field as tested in step 2 from the structure obtained
> by the second copy_from_user or a function call with the structure as an
> argument

This looks pretty good!

> In the case where the second copy_from_user stores the result in a
> pointer, then a return with no reference of the tested field is also a
> concern, unless, the pointer was already kfreed.

I think sequence "2" above missing just looking at a direct value,
like if instead of a field it was a u32. Also, should binop include
"=="?

And we need to add back in get_user() too... hmmm

-Kees

-- 
Kees Cook
Nexus Security
