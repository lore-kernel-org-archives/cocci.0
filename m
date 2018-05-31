From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 31 May 2018 07:57:12 +0200 (CEST)
Subject: [Cocci] Increase precision for display of SmPL script execution
 durations
In-Reply-To: <c12b39fa-4403-074f-68f3-dc457608d944@users.sourceforge.net>
References: <b36b5d25-1784-6228-a689-0dbf8d15ffb0@users.sourceforge.net>
 <alpine.DEB.2.20.1805302233130.2349@hadrien>
 <c12b39fa-4403-074f-68f3-dc457608d944@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805310756150.2292@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 31 May 2018, SF Markus Elfring wrote:

> >> How do you think about to show this detail precisely?
> >
> > Normally, one uses --profile to find the things that take seconds,
> > not to find the thing that take less than 0.01 seconds.
>
> These values might look negligible.
> I find the display of the information ?0.000 sec? inappropriate.
> https://github.com/coccinelle/coccinelle/blob/445c214e755dc74fae1d205d686365767ee64e85/commons/common.ml#L648
>
> An adjustment (of a format string) could be so simple like the following.
>
> diff --git a/commons/common.ml b/commons/common.ml
> index 7cbeceaf..ca5399ad 100644
> --- a/commons/common.ml
> +++ b/commons/common.ml
> @@ -657,7 +657,7 @@ let profile_diagnostic () =
>        pr "profiling result";
>        pr "---------------------";
>        xs +> List.iter (fun (k, (t,n)) ->
> -        pr (Printf.sprintf "%-40s : %10.3f sec %10d count" k !t !n)
> +        pr (Printf.sprintf "%-40s : %f sec %10d count" k !t !n)

I know that the change is simple.  But I don't want to see so many digits,
most of which are meaningless.  In 46.742592, I'm only interested in the
46.

julia

>        )
>      )
>
>
> Regards,
> Markus
>
