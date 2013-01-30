From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 30 Jan 2013 11:37:29 +0100 (CET)
Subject: [Cocci] Dangling whitespace on added newlines
In-Reply-To: <51083AC6.1000606@redhat.com>
References: <51083AC6.1000606@redhat.com>
Message-ID: <alpine.DEB.2.02.1301301137150.1990@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 29 Jan 2013, Michael Stefaniuc wrote:

> Hello,
>
> when coccinelle automatically adds a newline after removing "{}" the
> added newline has dangling whitespace corresponding to the indentation
> level. Please see the attached test case and generated patch.

Thanks for the report.  We will look into it.

julia
