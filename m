Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02816ECAAD5
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 07:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rOqNXOHtDEsiG33pbovfd2S/1l6930Jsqox4dc8qJkw=;
  b=mHT0icHgVk7kmQohuZDyOMGB40sEYPi87vG9gTFjP3BUqH0LJbuaMG2d
   0NfCWz/YuNs8lQ54cX6l02lggYDV/Z0GAiSAjD/u7DvKAMd3a3NgEAwtz
   sdL0d+WmDKVUM2CBvZnn1wxunytxozPiZdXpXccoHbrWPorgAku2yk52a
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,290,1654552800"; 
   d="scan'208";a="51267086"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 09:57:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 029ECE779D; Mon,  5 Sep 2022 09:57:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C97D0E015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 09:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rOqNXOHtDEsiG33pbovfd2S/1l6930Jsqox4dc8qJkw=;
  b=r0ycAaFzL/WJTZAZd9NzZczHWUuXd1FMei3g4BzPyx4myTucN7B90HpU
   ZDiNHHX+1VfrihYZoUJkynpX6CLe6Y4N7IUGPvGfTjE51K3Q1XCO7A8tu
   wO92W9WTSJnqTP/rgQj58PpA6sdWa3xd0vOYjRRuUAdIppgj/zc3JUzeK
   Y=;
X-IronPort-AV: E=Sophos;i="5.93,290,1654552800"; 
   d="scan'208";a="51267066"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 09:57:34 +0200
Date: Mon, 5 Sep 2022 09:57:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <20220904225006.3438769-1-jtojnar@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2209050952300.2731@hadrien>
References: <20220904225006.3438769-1-jtojnar@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2055935256-1662364653=:2731"
Subject: Re: [cocci] [PATCH] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 537
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209050952300.2731%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2055935256-1662364653=:2731
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 5 Sep 2022, Jan Tojnar wrote:

> When an error occurs during patching of a file, the process terminates
> with a 255 exit code.
>
>     spatch docs/dev/file-path-error.cocci docs/dev/test1.c
>
> This was not the case when trying to apply the patch on a directory:
>
>     spatch docs/dev/file-path-error.cocci docs/dev/
>
> The process would print errors for each file individually,
> and then finish with a zero (success) exit code.
> Additionally, it would write out files for files that succeeded.
>
> Let’s exit with 255 when failure occurs during the mass patching
> as well, and prevent writing the changes of successful transformations
> to avoid the chance of accidentally not noticing the failure.

It looks like this breaks the testing infrastructure.

> ---
>  enter.ml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/enter.ml b/enter.ml
> index 53d4753f..56a4d4c6 100644
> --- a/enter.ml
> +++ b/enter.ml
> @@ -1083,6 +1083,7 @@ let rec main_action xs =
>    | _ -> failwith "only one .cocci file allowed");
>    Iteration.base_file_list := xs;
>    previous_merges := ([], []);
> +  let patching_failed = ref false in
>    let rec toploop = function
>        [] -> failwith "no C files provided"
>      | x::xs ->
> @@ -1366,6 +1367,7 @@ singleton lists are then just appended to each other during the merge. *)
>  					    (Printexc.to_string e)
>  					    all_cfiles;
>  					  flush stderr;
> +					  patching_failed := true;
>  					  prev (* *)
>  					end
>  					else raise e) in
> @@ -1414,6 +1416,10 @@ singleton lists are then just appended to each other during the merge. *)
>  		  (x,xs,cocci_infos,outfiles)
>  		end) in
>        let (x,xs,cocci_infos,outfiles) = toploop xs in
> +      if !patching_failed then begin
> +        Printf.fprintf stderr "An error occurred when attempting to transform some files.\n";
> +        raise (UnixExit (-1))
> +      end;

Maybe put:

if !patching_failed && not !Flag_ctl.bench && not !compare_with_expected
then
  begin
    ...
  end

Please add the appropriate:

Signed-off-by: Random J Developer <random@developer.example.org>

See readme.txt at the root of the source directory.

thanks,
julia

>        Common.profile_code "Main.result analysis" (fun () ->
>  	Ctlcocci_integration.print_bench();
>  	generate_outfiles outfiles x xs;
> --
> 2.37.2
>
>
--8323329-2055935256-1662364653=:2731--
