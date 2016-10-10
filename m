From: Nikolaus@rath.org (Nikolaus Rath)
Date: Mon, 10 Oct 2016 08:56:56 -0700
Subject: [Cocci] Replacing one (specific!) type with another
In-Reply-To: <alpine.DEB.2.10.1610100653510.3148@hadrien> (Julia Lawall's
 message of "Mon, 10 Oct 2016 06:54:37 +0200 (CEST)")
References: <87r37vzd8j.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610050744460.3061@hadrien>
 <87shsa7p71.fsf@thinkpad.rath.org>
 <alpine.DEB.2.10.1610052158110.3130@hadrien>
 <8760p3jwr3.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610080727090.3176@hadrien>
 <87ponay35u.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610082317180.3373@hadrien>
 <87wphhz1x5.fsf@vostro.rath.org>
 <alpine.DEB.2.10.1610100653510.3148@hadrien>
Message-ID: <877f9gqjsn.fsf@vostro.rath.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Oct 10 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Sun, 9 Oct 2016, Nikolaus Rath wrote:
>
>> On Oct 08 2016, Julia Lawall <julia.lawall@lip6.fr> wrote:
>> >> > Write separate rules for that.  You would need one case for a local
>> >> > variable and one case fora parameter.  You can actually probably just drop
>> >> > the rule you have currently.  I would imagine something like the
>> >> > following:
>> >> >
>> >> > @@
>> >> > symbol f, se; // avoid unneeded warnings from Coccinelle
>> >> > @@
>> >> >
>> >> > struct fuse_session *
>> >> > -f
>> >> > +se
>> >> >  ;
>> >> > <...
>> >> > -f
>> >> > +se
>> >> > ...>
>> >> > @@
>> >> > identifier fn;
>> >> > @@
>> >> >
>> >> > fn(...,struct fuse_session *f,...) { <...
>
> Oops, the first line should be:
>
> fn(...,struct fuse_session *
> -f
> +se
>   ,...) { <...
>
> The rule works fine even when f is the first argument.

Ouch, I guess I could have caught that too. Works like a charm now!


Best,
-Nikolaus

-- 
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             ?Time flies like an arrow, fruit flies like a Banana.?
