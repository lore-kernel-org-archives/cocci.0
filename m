From: asmadeus@codewreck.org (Dominique Martinet)
Date: Fri, 20 Jul 2018 07:40:50 +0200
Subject: [Cocci] [PATCH v3] coccinelle: suggest replacing
 strncpy+truncation by strscpy
In-Reply-To: <alpine.DEB.2.20.1807200731240.2349@hadrien>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
 <1532047018-23754-1-git-send-email-asmadeus@codewreck.org>
 <alpine.DEB.2.20.1807200731240.2349@hadrien>
Message-ID: <20180720054050.GA32233@nautica>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia Lawall wrote on Fri, Jul 20, 2018:
> > strscpy does however not clear the end of the destination buffer, so
> > there is a risk of information leak if the full buffer is copied as is
> > out of the kernel - this needs manual checking.
> 
> As fasr as I can tell from lkml, only one of these patches has been
> accepted?  There was also a concern about an information leak that there
> was no response to.  Actually, I would prefer that more of the generated
> patches are accepted before accepting the semantic patch, for something
> that is not quite so obviously correct.

As I'm pointing to the script which generated the patch in the generated
patches, I got told that it would be better to get the coccinelle script
accepted first, and asked others to hold on taking the patches at
several places - I didn't resend any v2 of these with strscpy yet mostly
for that reason.


There were concerns for information leaks that I believe I adressed in
the specific patch that was pointed out by the concern (I might have
missed some?), but I'll take the time to check all the patches
individually before resending as well as filling in better commit
messages which also was one of the main concerns.

I'm however a bit stuck if I'm waiting for the cocinelle script to be
accepted to resend the patches, but you're waiting for the individual
patches to be accepted to take the script... :)


I guess there is no value in the script landing first by itself, I'll
just remove the script path from the commit messages and resend the
first few this weekend.

-- 
Dominique Martinet
