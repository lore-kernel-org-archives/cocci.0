From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 18 Oct 2012 09:19:26 +0200 (CEST)
Subject: [Cocci] Mysterious parsing issue.
In-Reply-To: <loom.20121017T191721-59@post.gmane.org>
References: <loom.20121017T191721-59@post.gmane.org>
Message-ID: <alpine.DEB.2.02.1210180916470.2000@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 17 Oct 2012, Mohit Gupta wrote:

> Hi,
>
> I am trying to parse this c file containing macros. ( C file and the macro file
> is pasted below.)  This parses fine, if I uncomment the first line "STATIC int
> abc;"
>
> If I uncomment the line but change the order so as to make the first line as "
> INT funcf ARGS((char *));" . Then again it gives parsing issues.
>
> Is the parsing supposed to be dependent on order of statements or preclusion of
> another statement ? Are we looking at a potential bug ?

I get a parse error with all permutations of INT funcf ARGS((char *)); and
STATIC int abc;.  Actually, I don't have the impression that STATIC int
abc; is relevant; it is the use of ARGS that it does not seem to like.

We can look into it.  But is it actually blocking what you want to do?  As
long as you are only interested in matching and transforming function
definitions, not function prototype declarations, the problem should not
have any impact.

julia
