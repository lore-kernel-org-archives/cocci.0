From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 6 Feb 2013 10:45:57 +0100 (CET)
Subject: [Cocci] C parse error: multiplication with pointer dereference
In-Reply-To: <51122558.3090509@redhat.com>
References: <51122558.3090509@redhat.com>
Message-ID: <alpine.DEB.2.02.1302061045320.1971@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 6 Feb 2013, Michael Stefaniuc wrote:

> Hello!
>
> I get this parse error for the attached test case:
> spatch --parse-c foo.c 2>&1 | grep BAD
> BAD:!!!!!     return i * *j;
>
> gcc -Wall -Werror has no issues with it.

It looks like a parsing hack gone wrong.  We will look into it.

julia
