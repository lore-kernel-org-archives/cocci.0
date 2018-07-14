From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 14 Jul 2018 07:54:29 -0400 (EDT)
Subject: [Cocci] [PATCH v2] coccinelle: strncpy+truncation by strscpy
In-Reply-To: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531555951-9627-1-git-send-email-asmadeus@codewreck.org>
Message-ID: <alpine.DEB.2.20.1807140750040.3356@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +msg = "SUGGESTION: strncpy followed by truncation can be strscpy, if the destination buffer does not need to be fully overwritten"
> +coccilib.report.print_report(p[0], msg)

This is the first SUGGESTION.  I don't know if anyone out there is relying
on it always being WARNING or ERROR.

julia
