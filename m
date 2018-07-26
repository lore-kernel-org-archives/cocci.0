From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Jul 2018 00:36:38 +0200 (CEST)
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
References: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807270034400.2489@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jul 2018, Timur Tabi wrote:

> Is there a way to edit string constants?  I need to change
>
> "NVRM: ...."
>
> into
>
> "..."
>
> That is, I need to remove the "NVRM: " from a string.  I tried this:
>
> @depends on rule1@
> @@
> -"NVRM: "
> +""
>
> But it doesn't do anything.

The easiest thing would be to use python.  You can look at
demos/pythontococci.cocci for an example.  If you send a complete change
that you would like to make, I can write an example rule.

julia
