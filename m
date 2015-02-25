From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 25 Feb 2015 07:27:12 +0100 (CET)
Subject: [Cocci] coccinelle / spatch and notes
In-Reply-To: <C48A0218-EB1C-4360-99C1-132FC0682F56@allegro.com>
References: <C48A0218-EB1C-4360-99C1-132FC0682F56@allegro.com>
Message-ID: <alpine.DEB.2.02.1502250726040.2063@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 24 Feb 2015, Stan Sieler wrote:

> Hi,
> 
> I'd like to request a "-q" or "-nonotes" option to disable notes like:
> 
>    Note: processing took    10.5s: ./rose/utility.c

Why does it bother you?  It goes onto standard error, so it doesn't 
disrupt the normal output.  I find it quite useful for detecting 
performance problems.  If you really need it to disappear, I can add 
another option, but we already have a lot of them...

julia
