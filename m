Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6EAC5472C
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2024 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:date:
   message-id:references:cc:in-reply-to:to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=41VudxRfBxr6WyiTUO2EumMvDfPCWZr5J6Tsbz9XP1I=;
  b=QRnluUrLZBZz92L5Sk1CJwZB6Kn2nMUKtCFvS2UN1iQ5bBT56Qb+wYIV
   ajACHfFWc2vLQg7n7O3z8mxI6iawbWR7zVNAg8UEZKricm6fSbxXjtvRJ
   pYZKJs7cjgyYNys7yBPmT5CCf1ZQ4ODq3HHYRORIWPqMG9Ry2IMQpqMFB
   o=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.10,173,1719871200"; 
   d="scan'208,217";a="179931969"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Aug 2024 14:56:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6425EE0145; Sat, 24 Aug 2024 14:56:37 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3E0B5E00B7
	for <cocci@sympa.inria.fr>; Sat, 24 Aug 2024 14:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=41VudxRfBxr6WyiTUO2EumMvDfPCWZr5J6Tsbz9XP1I=;
  b=gUr6EroqAQUur6rLBxfGBXvH9LWVAaipY9wAI3W8gPjl938UWlMaQ3bE
   aX/BFAEP/Xu80ZJy75/jYmH8SVa30GS77e7XHli+rXEL1EEyikeX9bH1o
   EP7wuVs/X1loT5iC7pwxg9TWpsV4vEqlwCSfcWJHxtZoew7DiuwV5m3Qs
   w=;
X-IronPort-AV: E=Sophos;i="6.10,173,1719871200"; 
   d="scan'208,217";a="179931966"
Received: from mannheim.de (HELO smtpclient.apple) ([212.65.1.69])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2024 14:56:35 +0200
Content-Type: multipart/alternative; boundary=Apple-Mail-365D7ED4-61F5-4130-83DD-727AFCD341DE
Content-Transfer-Encoding: 7bit
From: Julia Lawall <Julia.Lawall@inria.fr>
Mime-Version: 1.0 (1.0)
Date: Sat, 24 Aug 2024 14:56:24 +0200
Message-Id: <25488C8C-BE4A-4182-BD19-4D04562CEC4A@inria.fr>
References: <983f5490-ee27-4558-832f-6d5af7344b79@gmail.com>
Cc: cocci@inria.fr
In-Reply-To: <983f5490-ee27-4558-832f-6d5af7344b79@gmail.com>
To: Mats Kindahl <mats.kindahl@gmail.com>
X-Mailer: iPhone Mail (21E236)
Subject: Re: [cocci] Symbolic names in iso-files
Reply-To: Julia Lawall <Julia.Lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1860
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/25488C8C-BE4A-4182-BD19-4D04562CEC4A%40inria.fr>


--Apple-Mail-365D7ED4-61F5-4130-83DD-727AFCD341DE
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

Can you just add semicolons in your isomorphism?
Sent from my iPhone

> On 24 Aug 2024, at 14:23, Mats Kindahl <mats.kindahl@gmail.com> wrote:
>=20
> =EF=BB=BF
> Hi all,
>=20
> In some code, there are macros used for different purposes. One typical ca=
se is having a "foreach" macro, but this is covered using "iterator" so that=
 you can deal with code like this:
>=20
> static Jsonb *BuildJsonObject(List *items) {
>   ListCell *cell;
>   JsonbParseState *state =3D NULL;
>   JsonbValue *value;
>=20
>   pushJsonbValue(&state, WJB_BEGIN_OBJECT, NULL);
>   foreach (cell, items) {
>     KVItem *item =3D (KVItem *)lfirst(cell);
>     AddJsonField(&state, item->key, item->value);
>   }
>   value =3D pushJsonbValue(&state, WJB_END_OBJECT, NULL);
>=20
>   return JsonbValueToJsonb(value);
> }
>=20
> However, if you want to make sure to deal with resource allocation and mak=
e sure that you release a short-lived lock, for example (grossly simplified,=
 just to demonstrate the problem):
>=20
> @@
> expression lock, mode;
> @@
>   LWLockAcquire(lock, mode);
>   ... when exists
> (
>   LWLockRelease(lock);
> |
> + LWLockRelease(lock);
>   return;
> )
>=20
> If fails miserably with this code:
>=20
> Datum start_worker(PG_FUNCTION_ARGS) {
>   pid_t pid;
>=20
>   if (!autoprewarm)
>     ereport(ERROR, (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
>                     errmsg("autoprewarm is disabled")));
>=20
>   apw_init_shmem();
>   LWLockAcquire(&apw_state->lock, LW_EXCLUSIVE);
>   pid =3D apw_state->bgworker_pid;
>=20
>   if (pid !=3D InvalidPid)
>     ereport(ERROR, (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),
>                     errmsg("autoprewarm worker is already running under PI=
D %d",
>                            (int)pid)));
>=20
>   apw_start_leader_worker();
>=20
>   PG_RETURN_VOID();
> }
>=20
> Giving the patch, where the call to LWLockRelease should be before the PG_=
RETURN_VOID:
>=20
> --- code/lwlock.c
> +++ /tmp/cocci-output-12611-ff946d-lwlock.c
> @@ -18,6 +18,7 @@ Datum start_worker(PG_FUNCTION_ARGS) {
>   apw_start_leader_worker();
> =20
>   PG_RETURN_VOID();
> +  LWLockRelease(&apw_state->lock);
> }
>=20
> Since this is such a common construct, and you do not want to deal with th=
is for every potential case, this seems like an obvious case for using an is=
o-file, so I created one that looks like this, with the idea that we support=
 replacing "PG_RETURN_VOID()" with just a "return".
>=20
> Statement
> @ pg_return @
> @@
>   PG_RETURN_VOID() =3D> return
>=20
> However, this fails with the following error message:
>=20
> mats@abzu:~/lang/cocci/hacks$ spatch --sp-file lwlock.cocci code/lwlock.c
> init_defs_builtins: /usr/lib/coccinelle/standard.h
> iso main: parse error: =20
>  File "./postgres.iso", line 4, column 19, charpos =3D 46
>  around =3D '=3D>',
>  whole content =3D   PG_RETURN_VOID() =3D> return
>=20
> Which I suppose mean that there is no support for handling anything but st=
andard tokens in an .iso file.
>=20
> Have I misunderstood the situation and this is already supported in some w=
ay?
>=20
> Are there any plans that add such support to the ISO grammar?
>=20
> Best wishes,
> Mats Kindahl, Timescale

--Apple-Mail-365D7ED4-61F5-4130-83DD-727AFCD341DE
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=3D=
utf-8"></head><body dir=3D"auto">Can you just add semicolons in your isomorp=
hism?<br id=3D"lineBreakAtBeginningOfSignature"><div dir=3D"ltr">Sent from m=
y iPhone</div><div dir=3D"ltr"><br><blockquote type=3D"cite">On 24 Aug 2024,=
 at 14:23, Mats Kindahl &lt;mats.kindahl@gmail.com&gt; wrote:<br><br></block=
quote></div><blockquote type=3D"cite"><div dir=3D"ltr">=EF=BB=BF

 =20

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-8"=
>
 =20
 =20
    <p>Hi all,</p>
    <p>In some code, there are macros used for different purposes. One
      typical case is having a "foreach" macro, but this is covered
      using "iterator" so that you can deal with code like this:</p>
    <blockquote>
      <p>static Jsonb *BuildJsonObject(List *items) {<br>
        &nbsp; ListCell *cell;<br>
        &nbsp; JsonbParseState *state =3D NULL;<br>
        &nbsp; JsonbValue *value;<br>
        <br>
        &nbsp; pushJsonbValue(&amp;state, WJB_BEGIN_OBJECT, NULL);<br>
        &nbsp; foreach (cell, items) {<br>
        &nbsp;&nbsp;&nbsp; KVItem *item =3D (KVItem *)lfirst(cell);<br>
        &nbsp;&nbsp;&nbsp; AddJsonField(&amp;state, item-&gt;key, item-&gt;v=
alue);<br>
        &nbsp; }<br>
        &nbsp; value =3D pushJsonbValue(&amp;state, WJB_END_OBJECT, NULL);<b=
r>
        <br>
        &nbsp; return JsonbValueToJsonb(value);<br>
        }<br>
      </p>
    </blockquote>
    <p>However, if you want to make sure to deal with resource
      allocation and make sure that you release a short-lived lock, for
      example (grossly simplified, just to demonstrate the problem):</p>
    <blockquote>
      <p>@@<br>
        expression lock, mode;<br>
        @@<br>
        &nbsp; LWLockAcquire(lock, mode);<br>
        &nbsp; ... when exists<br>
        (<br>
        &nbsp; LWLockRelease(lock);<br>
        |<br>
        + LWLockRelease(lock);<br>
        &nbsp; return;<br>
        )<br>
      </p>
    </blockquote>
    <p>If fails miserably with this code:</p>
    <blockquote>
      <p>Datum start_worker(PG_FUNCTION_ARGS) {<br>
        &nbsp; pid_t pid;<br>
        <br>
        &nbsp; if (!autoprewarm)<br>
        &nbsp;&nbsp;&nbsp; ereport(ERROR,
        (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errmsg("autoprewarm is disabl=
ed")));<br>
        <br>
        &nbsp; apw_init_shmem();<br>
        &nbsp; LWLockAcquire(&amp;apw_state-&gt;lock, LW_EXCLUSIVE);<br>
        &nbsp; pid =3D apw_state-&gt;bgworker_pid;<br>
        <br>
        &nbsp; if (pid !=3D InvalidPid)<br>
        &nbsp;&nbsp;&nbsp; ereport(ERROR,
        (errcode(ERRCODE_OBJECT_NOT_IN_PREREQUISITE_STATE),<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errmsg("autoprewarm worker is=
 already
        running under PID %d",<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (int)pid)));<br>
        <br>
        &nbsp; apw_start_leader_worker();<br>
        <br>
        &nbsp; PG_RETURN_VOID();<br>
        }</p>
    </blockquote>
    <p>Giving the patch, where the call to LWLockRelease should be
      before the PG_RETURN_VOID:</p>
    <blockquote>
      <p><span style=3D"font-family:monospace"><span style=3D"color:#000000;=
background-color:#ffffff;">---
            code/lwlock.c
          </span><br>
          +++ /tmp/cocci-output-12611-ff946d-lwlock.c
          <br>
          @@ -18,6 +18,7 @@ Datum start_worker(PG_FUNCTION_ARGS) {
          <br>
          &nbsp;&nbsp;apw_start_leader_worker();
          <br>
          &nbsp;<br>
          &nbsp;&nbsp;PG_RETURN_VOID();
          <br>
          + &nbsp;LWLockRelease(&amp;apw_state-&gt;lock);
          <br>
          }<br>
        </span></p>
    </blockquote>
    <p>Since this is such a common construct, and you do not want to
      deal with this for every potential case, this seems like an
      obvious case for using an iso-file, so I created one that looks
      like this, with the idea that we support replacing
      "PG_RETURN_VOID()" with just a "return".<br>
    </p>
    <blockquote>
      <p>Statement<br>
        @ pg_return @<br>
        @@<br>
        &nbsp; PG_RETURN_VOID() =3D&gt; return<br>
      </p>
    </blockquote>
    <p>However, this fails with the following error message:</p>
    <blockquote>
      <p><span style=3D"font-family:monospace"><span style=3D"font-weight:bo=
ld;color:#54ff54;background-color:#ffffff;">mats@abzu</span><span style=3D"c=
olor:#000000;background-color:#ffffff;">:</span><span style=3D"font-weight:b=
old;color:#5454ff;background-color:#ffffff;">~/lang/cocci/hacks</span><span s=
tyle=3D"color:#000000;background-color:#ffffff;">$ spatch
            --sp-file lwlock.cocci code/lwlock.c
          </span><br>
          init_defs_builtins: /usr/lib/coccinelle/standard.h
          <br>
          iso main: parse error: &nbsp;<br>
          &nbsp;File "./postgres.iso", line 4, column 19, charpos =3D 46
          <br>
          &nbsp;around =3D '=3D&gt;',
          <br>
          &nbsp;whole content =3D &nbsp;&nbsp;PG_RETURN_VOID() =3D&gt; retur=
n<br>
        </span></p>
    </blockquote>
    <p>Which I suppose mean that there is no support for handling
      anything but standard tokens in an .iso file.</p>
    <p>Have I misunderstood the situation and this is already supported
      in some way?</p>
    <p>Are there any plans that add such support to the ISO grammar?</p>
    <p>Best wishes,<br>
      Mats Kindahl, Timescale<br>
    </p>
 =20

</div></blockquote></body></html>=

--Apple-Mail-365D7ED4-61F5-4130-83DD-727AFCD341DE--
