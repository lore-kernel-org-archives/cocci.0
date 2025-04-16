Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCEEC369BA
	for <cocci@archiver.kernel.org>; Wed, 16 Apr 2025 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=dSirZkqhUf2i4Ixki3Js56KR9a63pRK+P5tWMI5O3wc=;
  b=L5yHCrWm8zZGaZ+Tv5qc2vZy2T61MIJ4NXsr7G8s8IpFNH+ESbMaa2l5
   h36Gqs/K1E94m/otNW2ZlkbnCrMNi5Wb6OWwPYmRddpsdyl132lBb2+of
   2v8PtyCvRoIqNP8LglIP15Bj/FdqxpJtDwhpnsXWKUvfF+5yTz4WQQlqv
   A=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.15,216,1739833200"; 
   d="scan'208";a="218181950"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2025 17:34:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D57F1E0264; Wed, 16 Apr 2025 17:34:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8867DE007A
	for <cocci@sympa.inria.fr>; Wed, 16 Apr 2025 17:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dSirZkqhUf2i4Ixki3Js56KR9a63pRK+P5tWMI5O3wc=;
  b=eCx9O0XL7d/FNt+3sL5m3TQpcCdmXVwfh2dtJQtKm/9ZSli8/GgzLfMP
   ldnTeF4GhjzR//w9p4BZW25ldKzJQTY5mSRBVOWWfKxRleXabeXjqUE/D
   X+vOCWJZz/ELsntLqisBvtRV0qgf3mqqhhoSu0CdsKieCluRoVvUU2VE6
   s=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739833200"; 
   d="scan'208";a="114440870"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 17:34:30 +0200
Date: Wed, 16 Apr 2025 17:34:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: brice.saugnac@scle.fr
cc: cocci@inria.fr
In-Reply-To: <PR1P264MB40381AACD357A6FF16D5582FE4B32@PR1P264MB4038.FRAP264.PROD.OUTLOOK.COM>
Message-ID: <8c76d2a-b54e-4b9a-8fc6-534bfeac556@inria.fr>
References: <PR1P264MB40381AACD357A6FF16D5582FE4B32@PR1P264MB4038.FRAP264.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-420377037-1744817669=:3399"
Subject: Re: [cocci] Utilisation coccinelle sur des [tres tres] gros
 fichiers source
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2688
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/8c76d2a-b54e-4b9a-8fc6-534bfeac556%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-420377037-1744817669=:3399
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

[Most people on the list don't speak French]

On Mon, 14 Apr 2025, brice.saugnac@scle.fr wrote:

>
> Bonjour, j’utilise coccinelle pour transformer du code.
>
> Mon besoin est de transformer tous les membres d’un type en pointeurs.
>
>  
>
> Cela marche bien pour de petites fonctions mais coccinelle bloque et reste
> dans un état figé pour de très grosses fonctions (130 membres dans la
> structure, 28000 lignes de code dans une fonction [c’est une fonction
> générée par matlab que je peux pas transmettre pour des problèmes de
> droits…])
>
>  
>
> J’utilise spatch de debian stable :
>
> spatch version 1.1.1 compiled with OCaml version 4.13.1
>
> Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc
> --libdir=/usr/lib --enable-ocaml --enable-python --with-python=python3
> --enable-opt
>
> OCaml scripting support: yes
>
> Python scripting support: yes
>
> Syntax of regular expressions: PCRE
>
>  
>
>  
>
> Est-ce que vous avez une idée magique (à part réduire la taille de la dite
> fonction 😊 )
>
>  
>
>  
>
> J’ai pour cela fait 2 règles :
>
>  
>
> @rule_c@
>
> identifier func;
>
> type in_t  =~ ".*_entrees_t";
>
> identifier in_struct;
>
> identifier a;
>
> fresh identifier E = "p" ## a;
>
> @@
>
> func (..., in_t in_struct ,...) {
>
> <...
>
> -in_struct->a
>
> +(*in_struct->E)
>
> ...>
>
> }

Is it essential to make the link with a parameter?  If you want in
practicte to do the transformation on all variables of the type, you can
do

idexpression in_t *in_struct;

If you want to keep the current structure, it would probably help a lot to
put on the command line --no-loops and --no-gotos.  You can also specify
these options in the semantic patch, by putting

#spatch --ho-loops --no-gotos

at the beginning.

julia

>  
>
> @rule_h@
>
> type t =~ ".*_entrees_t$";
>
> type T;
>
> identifier OLD =~ "^(?!p).*$";
>
> fresh identifier E = "p" ## OLD;
>
> @@
>
> typedef struct {
>
> ...
>
> -T OLD;
>
> +T * E;
>
> ...
>
> } t;
>
>  
>
>  
>
>  
>
>  
>
> Cela me transforme bien :
>
>  
>
> typedef struct {
>
>         int toto;
>
>         int titi;
>
> } ma_struct_entrees_t;
>
>  
>
> typedef struct {
>
>         int out;
>
> } ma_out;
>
>  
>
> int ma_fonction(int occ, ma_struct_entrees_t *pst_in, ma_out *pst_out) {
>
>    pst_out->out = 4*((2*pst_in->toto) + pst_in->titi);
>
>  
>
>    return 0;
>
> }
>
>  
>
>  
>
>  
>
> Et me cree un patch correct :
>
>  
>
> diff =
>
> --- test_cocci.c
>
> +++ /tmp/cocci-output-1438-90cfe3-test_cocci.c
>
> @@ -1,6 +1,6 @@
>
> typedef struct {
>
> -       int toto;
>
> -       int titi;
>
> +       int *ptoto;
>
> +       int *ptiti;
>
> } ma_struct_entrees_t;
>
>  
>
> typedef struct {
>
> @@ -8,7 +8,7 @@ typedef struct {
>
> } ma_out;
>
>  
>
> int ma_fonction(int occ, ma_struct_entrees_t *pst_in, ma_out *pst_out) {
>
> -   pst_out->out = 4*((2*pst_in->toto) + pst_in->titi);
>
> +   pst_out->out = 4*((2*(*pst_in->ptoto)) + (*pst_in->ptiti));
>
>  
>
>     return 0;
>
> }
>
>  
>
>  
>
>
>
--8323329-420377037-1744817669=:3399--
