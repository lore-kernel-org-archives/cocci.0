From: keescook@chromium.org (Kees Cook)
Date: Fri, 18 Aug 2017 12:48:02 -0700
Subject: [Cocci] isomorphism for &(structure)->field vs struct.field
In-Reply-To: <alpine.DEB.2.20.1708181906240.17742@hadrien>
References: <CAGXu5jJygEODLuphzbxgiUQ_Box3LZy1kOBiHS7Fp5jAkpOVGQ@mail.gmail.com>
 <alpine.DEB.2.20.1708181906240.17742@hadrien>
Message-ID: <CAGXu5jLVmZMKGdhLECEo0phyzA0O3KdrM4dLCXT_+vw=3LvcmA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Aug 18, 2017 at 10:08 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Fri, 18 Aug 2017, Kees Cook wrote:
>
>> I'd like to have a rule that would match both:
>>
>> function(ptr);
>> ptr->field = 7;
>>
>> and
>>
>> function(&obj);
>> obj.field = 7;
>>
>> to produce:
>>
>> new_function(ptr, 7);
>>
>> and
>>
>> new_function(&obj, 7);
>>
>> respectively. The internal isomorphisms don't seem to cover this? Or
>> I'm maybe doing something wrong?
>
> There is no isomorphism for that.  Perhaps you cold live with the
> following?
>
> @@
> expression x,e;
> @@
>
> -f
> +g
>   ( \(&x\|x\)
> +, e
>   );
> - \(x.field\|x->field\) = e;

Ah, perfect, thanks!

-Kees

-- 
Kees Cook
Pixel Security
