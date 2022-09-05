Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF52ECAAD5
	for <cocci@archiver.kernel.org>; Mon,  5 Sep 2022 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:content-id:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=NssTlFjV5tgJqLiTXU74GLrPIEv0A8l/f4ATZGfNnxI=;
  b=r7R3hZeBddC688s+ujCocXxgo6BTMpFPEoeuO4lRq5jD5HwDIp63OGjC
   aPyLY30T0KZKYxhpANbKdJJdHPf7dttOoN43+fC65wDPUJrbWh+PBAQBD
   U3A3d/Gs1gLI1hgzsAbiM7ivLN2CSFr7lJDHaPJpV8/yZ75/VhLNBvdfm
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="51315622"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Sep 2022 12:48:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C64E3E779D; Mon,  5 Sep 2022 12:48:05 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 76AA9E015F
	for <cocci@sympa.inria.fr>; Mon,  5 Sep 2022 12:48:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=NssTlFjV5tgJqLiTXU74GLrPIEv0A8l/f4ATZGfNnxI=;
  b=paWZdGqrxzkfmD0Tr3p2n5zrZMBAQEEHqn0kST2r2/hA0RM7Eck3eUH7
   afKWx2yP4l0L+2o6+272iUsQu7gKkrtWbtoK5p+x3w24HZl/gz0TgXr3t
   CuV1pBqEF7yYXJrQe0s/Y4S8CiSJs/YyCmV8tLwOCqiQ0YYyD/HSog56v
   k=;
X-IronPort-AV: E=Sophos;i="5.93,291,1654552800"; 
   d="scan'208";a="22867297"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 12:48:04 +0200
Date: Mon, 5 Sep 2022 12:48:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Jan Tojnar <jtojnar@gmail.com>
cc: cocci@inria.fr
In-Reply-To: <20220905090915.3569051-1-jtojnar@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2209051246490.2731@hadrien>
References: <alpine.DEB.2.22.394.2209050952300.2731@hadrien> <20220905090915.3569051-1-jtojnar@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1959638460-1662374810=:2731"
Content-ID: <alpine.DEB.2.22.394.2209051246540.2731@hadrien>
Subject: Re: [cocci] [PATCH v2] Exit with non-zero status when spatch on a
 directory fails
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 540
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/alpine.DEB.2.22.394.2209051246490.2731%40hadrien>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1959638460-1662374810=:2731
Content-Type: text/plain; CHARSET=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2209051246541.2731@hadrien>



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
> Let¢s exit with 255 when failure occurs during the mass patching
> as well, and prevent writing the changes of successful transformations
> to avoid the chance of accidentally not noticing the failure.
>
> Let¢s also introduce a `--keep-going` flag that reverts to the previous
> behaviour. And also do the same with `--bench` and `--compare-with-expected`
> since the testing infrastructure relies on it.
>
> Signed-off-by: Jan Tojnar <jtojnar@gmail.com>
> ---
>
> Thansk, updated as per your instructions.
>
> Though, I think, ideally, the test infrastructure would be updated
> to use the newly introduced `--keep-going` flag and the magic
> behaviour of `--bench` and `--compare-with-expected` would
> be removed. I would do that but was not able to find any
> uses of the two flags in the repo.

I'm not sure to understand the point.  --bench and --compare-with expected
don't mean at all the same thing as just keep going.  --bench prints some
statistics about the CTL mating, and --compare-with-expected checks that
the result is the same as the one indicated in a .res file.

julia

>
>  enter.ml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/enter.ml b/enter.ml
> index 53d4753f..b4fac617 100644
> --- a/enter.ml
> +++ b/enter.ml
> @@ -28,6 +28,7 @@ let preprocess = ref false     (* run the C preprocessor before cocci *)
>  let compat_mode = ref false
>  let ignore_unknown_opt = ref false
>  let profile_per_file = ref false
> +let keep_going = ref false
>
>  let dir = ref false
>  let ignore = ref []
> @@ -729,6 +730,8 @@ let other_options = [
>      "   option to set if launch spatch in ocamldebug";
>      "--disable-once",       Arg.Set Common.disable_pr2_once,
>      "   to print more messages";
> +    "--keep-going",         Arg.Set keep_going,
> +    "     write transformations and exit with zero status, even if some files fail";
>      "--show-trace-profile", Arg.Set Common.show_trace_profile,
>      "   show trace";
>      "--save-tmp-files",     Arg.Set Common.save_tmp_files,   " ";
> @@ -1083,6 +1086,7 @@ let rec main_action xs =
>    | _ -> failwith "only one .cocci file allowed");
>    Iteration.base_file_list := xs;
>    previous_merges := ([], []);
> +  let patching_failed = ref false in
>    let rec toploop = function
>        [] -> failwith "no C files provided"
>      | x::xs ->
> @@ -1366,6 +1370,7 @@ singleton lists are then just appended to each other during the merge. *)
>  					    (Printexc.to_string e)
>  					    all_cfiles;
>  					  flush stderr;
> +					  patching_failed := true;
>  					  prev (* *)
>  					end
>  					else raise e) in
> @@ -1414,6 +1419,12 @@ singleton lists are then just appended to each other during the merge. *)
>  		  (x,xs,cocci_infos,outfiles)
>  		end) in
>        let (x,xs,cocci_infos,outfiles) = toploop xs in
> +      if !patching_failed && not !keep_going && !Flag_ctl.bench == 0 && !compare_with_expected == None
> +      then
> +        begin
> +          Printf.fprintf stderr "An error occurred when attempting to transform some files.\n";
> +          raise (UnixExit (-1))
> +        end;
>        Common.profile_code "Main.result analysis" (fun () ->
>  	Ctlcocci_integration.print_bench();
>  	generate_outfiles outfiles x xs;
> --
> 2.37.2
>
>
--8323329-1959638460-1662374810=:2731--
