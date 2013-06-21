From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Fri, 21 Jun 2013 10:19:05 +0200
Subject: [Cocci] Improvements for Coccinelle API
In-Reply-To: <51C400D3.5060505@users.sourceforge.net>
References: <alpine.DEB.2.02.1306192330420.2023@localhost6.localdomain6>
 <51C400D3.5060505@users.sourceforge.net>
Message-ID: <CAAxaTiOxbmvRZxCQ6tO9oKot0t0jrVn8S0e8XtsMKvEmCpYkkA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jun 21, 2013 at 9:29 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>
>> A third option would be to make it possible to refer to eg virtual.xyz
>> directly in the script code, regardless of the language.
>
>
> I would prefer such an approach.

For me, it is the worst of the three options.
Are you going to implement it
and to maintain it in the long term ?


> I'd like to suggest that a specific
> function will return an object which provides access to a general
> application programming interface for Coccinelle.

We already have that...

>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



--
Nicolas Palix
Tel: +33 4 76 51 46 27
http://membres-liglab.imag.fr/palix/
