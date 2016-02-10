From: kborer@gmail.com (Kris Borer)
Date: Wed, 10 Feb 2016 10:06:23 -0500
Subject: [Cocci] coccinelle: add style check for assignment in if
In-Reply-To: <56BAFC45.5000003@users.sourceforge.net>
References: <1454935571-4054-1-git-send-email-kborer@gmail.com>
 <56B9A2F6.4040109@users.sourceforge.net>
 <alpine.DEB.2.10.1602091016200.2578@hadrien>
 <56B9E1C2.7070008@users.sourceforge.net> <1455062207.3333.6.camel@perches.com>
 <56BAFC45.5000003@users.sourceforge.net>
Message-ID: <CAMy_N63v0DqwMN4Y56OrMmYTFjS5Knn6ZxKC6WGprGS2tY66mg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Feb 10, 2016 at 4:00 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> Kris Borer suggested a SmPL script which can generate (only) patches
> so far by the usual application of the Coccinelle software.
> I assume that this approach was limited just because Julia Lawall
> indicated that this functionality would be sufficient for a while.
>
> * Do you find the report mode also useful occasionally?
>
> Are you interested to get further output variants?
>
> Examples:
> * CSV
> * XML

I would happy to add additional modes or features, but I would prefer
to do those in a separate patch if possible.
