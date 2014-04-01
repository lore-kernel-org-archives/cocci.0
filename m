From: joe@perches.com (Joe Perches)
Date: Tue, 01 Apr 2014 16:11:16 -0700
Subject: [Cocci] coccinelle: trivial linux code style reformatting
In-Reply-To: <CA+MoWDr-vry3W3T-duYPYr=H4b3OE0YshuDN9caH56o+WE4CQA@mail.gmail.com>
References: <1396374174.21529.93.camel@joe-AO722>
 <CA+MoWDr-vry3W3T-duYPYr=H4b3OE0YshuDN9caH56o+WE4CQA@mail.gmail.com>
Message-ID: <1396393876.21529.99.camel@joe-AO722>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2014-04-01 at 20:29 +0200, Peter Senna Tschudin wrote:
> I changed the first rule to:
> 
> @@
> identifier func;
> expression S,E;
> @@
> void func(...) {
> ...
> - if (E) return S;
> + if (E) {S; return;}

Thanks Peter, that makes more sense than
what I wrote.

cheers, Joe
