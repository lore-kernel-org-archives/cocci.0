Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33E7C433F5
	for <cocci@archiver.kernel.org>; Wed, 23 Mar 2022 06:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=NOwyoW0gIqo5bLMw7S4p36KgoWzLRxRqX2H/InyHFoI=;
  b=p9ZmabTTvooKm4yPO9nzLV/PWH+R2FswERYoV38DlIZXAnwefM2CH8xU
   culnVASwUOQi8X6ErtDzo/k3CvW2JviwsF1eurpnmGs2O343WrbxyB++7
   qUkejEm9jaloF6n47QeSAZ7zJaMoTIvjImFwgKREZS5DEdWRF/mYi8EVC
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.90,203,1643670000"; 
   d="scan'208";a="27588029"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Mar 2022 07:01:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8B72FE4020; Wed, 23 Mar 2022 07:01:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A49D3E4020
	for <cocci@sympa.inria.fr>; Wed, 23 Mar 2022 07:00:57 +0100 (CET)
IronPort-SDR: 9BztupiuXQn3BWJSKX4mcaY7/JUVwJuf8FO+Wk7fuATj68ZqELlzbrqyuZZeTO4rQFj/M3j7D+
 qq0j8FDz3QjxSwrp6fSFTZlNZTjc5mJMFx9u7RKkmch5G19ySS1ktqbywuVCIVaDpyXSasU9WX
 MbdjRlxIScr1hQ85HzZbeMm0Ii0UGifiHMUfr9ZfVdsilO/7Iz0CK+vgQC9GT5yCTOFJhd0gyl
 58QxUcyICoL5ICxCDvLe8YFA6In95LNDZFKDAyT45bSPFP/uw2abVlPW582fbQQhXZqvXWMECZ
 YdG7FHSkQCfP6CbqbMEMg7kL
X-IPAS-Result: =?us-ascii?q?A0BdBQDmtjpi/0Xcza1agQmEAgd3VgEBASkEC5QLgiieX?=
 =?us-ascii?q?wsBAwENMhEEAQGEQkUChEQCHQYGNBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBAFWMiwBYwFnAYFOAYF5BgQwDYI1KQGDZAEFOj8QCxguVwaDFwGDF?=
 =?us-ascii?q?g+sUoEzgQGDTwGGJQaBPI5KJxxAgU2BFYMqPoJjAgKHXQSZWIFsUTqiFp4Wg?=
 =?us-ascii?q?1OLD5RPGi6WSZF3lluNFZQ8hTGBPzklgVkfFBoIJgo7gmpNAQIBAgEMAQICA?=
 =?us-ascii?q?QIBAgECAQgBAQIBkg6KfiEBAQE8LQIGCwEBAwmQUgEB?=
IronPort-PHdr: A9a23:o9QNdhH5durwh6o7QkxPtp1Gf/BHhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k31hmQAduQu60MotGVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5YPfbx9ViDeyYL5+I
 xa7oAfMvcQKnIVuLbo8xAHUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2Q
 rxeFzQmLns65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD+v9
 LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQds4YS2VcRMZcTyJPDIOiY
 YUSDeUPPuhYoIbhqFYVsRuyGROhCP/zxjNUmHP727Ax3eQ7EQHB2QwtB90AsG7VrNrpKawdU
 eC1w7fWwjXHcfxWwyr25Y/UfRAmvf6DQbNwfNHVyUkuDAPFkk6QpZb7MDKb1uQCrXaU7+5+W
 uK1kWInrR9+oiS2y8oql4LGiZ4bxEre+iVl3IY6O8e4SEhjbNO4EpZcqTyXOot4TM0tX2xmt
 yk0xqEGtJC1fCYHx4kqyhDCZvGDbYWE/A/uWuiRLzpmhH9oebKxiwq2/ES81ODxUNS/3lhNr
 ipAiNbMt3YN2gTc6siGVvt9/lqh1i2V2w/P7eFEJEY5nrfYJZ452rM8i5gevErZEiPohEn7j
 LWaels69uS08ejqY7Hrq5mBPIFukA7+KL4hmsmnDOQ4LAcOW2+b9Py51Lzs50H2XrtLjv0on
 abHtJDVO94bqrS/AwBLzoYv8xe/DzG439QEhXQLMVBIdRydg4T3J13DIOr0Aemhj1iwijtmx
 vTLMqXkAprXL3jDlLnhfax6605Z0Ac80ddf6I5IBbEAO//zXk7xtMfEDh8iKQC73ejmCNVj2
 YwAXWKAHLWZPLnUsVCW+uIjO++Ma5QNtzbnN/cl/+LujWM+mVIFYKWlxYEXZ2ygHvR6P0WZZ
 mLhjcsGEWgWogU+TffniEaCUD5Wf3a9Rbgw5jA9CIK8DIfMXJqhgLKb3HTzIpoDQGFNDVSFC
 j/QfoGFS79YbiOZJctoiXocXLygW6c80xCw8QDgxrxgJO7ZvyQcrZ/4ktZvsb79jxY3oBFuD
 s/V7GGAQmV5hCtcTDg916FXpU1m1kzF3Ld4jvFcGMYV4f5VBFRpfaXAxvB3XoihEjnKec2EH
 RP/Go3O6VAZS9swx4VLeENhA5C4iRuF2SO2ArgTnrjNBZou86ua0WKib91lxSPg068sx0IjX
 tMJLXev06V4/APSL4rIiFmC0au1dakR2CPXsmGO0TnGp1lWBSh3V6iNRnUDfg3TpNX96FnFS
 uqlDr8sMyNFyNWeMe1Hdd3kgFFLXrHlNciNK3mplTKWAhCFjqiJcJKse2gZ23DFD1MYlgkI4
 XucHQ0uQCq+o2/TCDF0U1TifysA6MFYr3W2Bg8xxgCONQh60qatvwQSjrqaQu8S2bQNvGEgr
 S91FRCzxYCeDd3IvAdncKhGBLF1qF5ayWLUsRB8NZ28PuhjgFAZaQF+o0Lp0V1+FIxBlcEgq
 H5iwhB1LOqU11ZIdjXQ2p6VWPWfIW759xGHb6/NxkqY3cmW96oL5e5+rVj//UmoGkck73R7w
 oxNyXLPg/eCRAEWUJ/3TgM2700j+OqcOHFgodmOjTsyYPrR0HeKwd8iCeo7xwz1et5eNPnBD
 wruC4gAAMPoLuU2ml+vZxZCPeZI9adyMdn1EpnOkKOtIutkmyqryGpd54UomEmL/CF9YurJx
 IoehfyH3gaKUzrmylGsroqk/OIMLSFXBWe5xSX+UcRaYaZ5fK4PCHyyOIu62dVziprgQThe+
 ULpVDZkkIe5PBGVaVL6xwhZ008a9GemlSWPxDtxizg1r6Cb0UQi2szEcxwKci5OTWhm1xL3J
 JSsysodVw6uZhQokx2s4QD7wbJareJxNTubR0AAZCXwI2x4N8n4/rOff85C7o8puiRLQay9Z
 16dULv0vxod1WvqAWJfwDkxczzitI/+mlR2j2eULXA7q3S8G4k4zhDU7930Qf9KwiFASTZ4h
 DTTC0L6OdS1vJ2Vm5rFruGiRjekX5xXfzPsyNDl1mPz7mlrDBuj2vGrz4S4Sk5giXK9jYMyE
 3uZ/3OeKsHx2q+3MPxqZBxtDV74sY9hH51m15E3j9cW0GQbgZOc+TwGl33yOJNVw/GbDjJFS
 DgVztrS+AWg1ldkKyfDzIXyXXS1xsp6e8L8b3wW1y854toMDqqIpu8h/2M9sh+joATdbOIo1
 DwawvAvwHobmP0S/gcyziiQBr0IW09VIWa/8nbAp8D7p6JRamG1dLG230crhtGtAoaJpQREU
 Wr4cJMvdcNpxuN4Nl+EkHj664W+PcLVccpWrBqf1RHJk+lSLps10PsMnytuf2zn7zUjzKYgg
 Bpi0Ivf3sDPInhx/K+/Hh9TNyHkL8IV9Db3iK9Cn8GQl4mxF5RlEz8PUdPmV/WtWD4VsP3mM
 U6JHlhe4j+DHqHDGAaE9Ep8h3ffVZ20N3yaIHQDi9NvWFjVJUBShhwVQCRvnpM9EVPPpoSpe
 0N46zYNo1/g/0ITkaQyb0S5CD2H4ln5OVJWANCFIRFb7x9P/RLQOM2atKdoGj1Au4emp0qLI
 3CaYAJBCScIXFaFDhbtJOrLh5GI/u6GC+65N/aLb6+JrLkUXPCDzpOH1op94y3KO9qPM3RmA
 ud93EdfFyMceYyRi3AURiobmjiYJdacvwu58zZro9qX9eStVR3v6IaLBqEUN9hzsUPT4+/LJ
 6ubgyB3Lixd35UHyCrTybQR61UVjjlnazinFbloXcvlSKPLhrQRAgEbZi53OdEO6a8gjFEl0
 S/zj8Oz26F4g/MxBk0DU1H9yJnBjSMiJ2CmKEiBCVmLObmCKCeNxczrM/vUdA==
IronPort-Data: A9a23:9q4Jbqmxy4IMwWVDwX4cqH7o5gyzIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xJNDG6DaKrYMGH9f9t0O4jkpx8AvpGAxtVgQAU5/iBnRVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTres1hlZHWeIcg944f5Ys7N/09YAbeSRWVvX4
 4up+ZeHZDdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /0ciJOKQioLYpGTieNBTSN8Nj9VM7dvreqvzXiX6aR/zmXDYz3h3PVjAUU7J8se9/of7WNmr
 KNDbmpVM1bZ3brwnuPTpupE3qzPKOHgO4gUu1lkzCrFFrArXpDOTqHH/5le0StYasVmR6mDN
 5pBMGQHgBLoYj1NZFUZS8IEscixqUvvY2xzpVOHnP9ii4TU5FctjuO8b4q9lsaxbc5SlU2Zj
 nnX+nzwRBAcLt2WjzSfmk9AncfKjWX2R4IfGbm17LhsjUH7KnEv5AM+BGa0m/KUqBKCBMNYd
 1Iu3g8whqYo3Rn+JjXiZCGQrHmBtx8aftNfFewm9Q2AopbpDxal6nssFWEeNYR33CMibXl7i
 Q/TxoKB6SlH6eXNERqgGqGoQSRe0BX5wEcHdWkJUgsI7t3uusc1gw6nojdf/Eyd1Y2d9dLYm
 WziQM0Ca1M715FjO0KTpwmvvt5UjsKVJjPZHy2ONo9lhysgDGJfW6Sm6ELA8dFLJ5uDQ1+Ks
 RAswpbCs7FRUcvSxX3RGY3h+Y1FAd7ealUwZnY0Q/EcG8mFoSP9FWyuyG4WyLhV3jYsImO3O
 x6M6Wu9FbdeI3unYKt6eYO3AIFylMDd+SfNDZjpgi51SsEpLme6ENdGOhbIhwgAUSEEz8kCB
 HtsWZ31XChAVvg/kmbeqiV0+eZD+x3SDFj7HfjTpylLG5LHDJJMYbtaYlaIcM4j66aI/Ffc/
 9pFbpvYzxRETPa4bzbX/IMXIEpMK3UnXMikp8tSf++FAwxnBGB4UaOKm+t8ItA8kvQHjPrM8
 1G8RlRclgj1i0rHHhrWOHptX7XiAMRkpnUhMC1xY1vxgyo/YZyi5bs0focseeV17/RqyPN5F
 qFXe8iJDvlVZC7A/jARMcv0oIB4LUT5gQOVIzHjbSc/cpNkShaP/NL4J1O9+C4LByuxlM0/v
 7z5jF+AG8JeHlg7AZ+POvy1zl63sXwMo85IXhPFcotJZUHh0Il2MCiv3PU5FME7NkmRzDWt0
 QvLUwwTovPAotJr/YCR17yEtYqgD8B3AlFeQzvA9b+zOCTXojijzItHXLradDzRTjqpqqCyI
 +hKz/zxNPAd2lBHr9MkQbpsyKs/4frppqNbl144Ry+TMg33U74wcGOb2cRvt7FWwuELswWBW
 nWQpotQN4KPNZ63C1UWPgckM7qOjKlGhjnI4P0pC0zm/ysrrqGfWEBfMkXekiBbN7cpYoopz
 f145ZwT+0qylRonP9KLlGZS+njVdi4MVKAut5c7Bo73i1NxlgoYOcGFVnb7sMOVdtFBEkg2O
 TvK1qDMsLRr2RaQeXQEE3WQj/FWgo4DuU0UwQZadUiJgNfMmtQ+wAZVrWYsVg1QwxhKuw6p1
 rOH66GhyWSyEzZUaAxrWnDqFh5BCRCd91a3zVYV/IEco49ESUSVRFDR+87UlKzaz46YVjxa5
 62Djmv6UTvneMzrmC0/RSaJbhAlocNZrmX/dQPOIyhBN507eib+xKKxZWcFrxb9R8U8mCUrY
 AWsEPlYMcXGCMLbn0H350R2G1jdpNBo6VGumc1cwZ4=
IronPort-HdrOrdr: A9a23:PRQhqalHdy4/hXGY06S+qQsdfYnpDfIo3DAbv31ZSRFFG/Fw9v
 re5cjyt3fP5wr5N0tPpTntAsi9qDbnhPtICOoqTNGftWvdyQ+VxehZhOOIrlHd8m/Fh4lgPM
 xbAspD4bPLbWSSUvyR3CCzGb8bsbq6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,203,1643670000"; 
   d="scan'208";a="27588016"
X-MGA-submission: =?us-ascii?q?MDHIaQ8ZtNNNg9uqnZwPnimpFMZ6u1lV5xsRoI?=
 =?us-ascii?q?r50Us9UPPUgL2vH4cqpD6zs5SMdoxstNVGX/EJl8jY17zYynwTq2W7/9?=
 =?us-ascii?q?2eTDH6NR79oy5awkEZuypde6yO1tgPFoJjCCC/tpr76ush0b8r+eGxn+?=
 =?us-ascii?q?oAiI+E7nfTdZ4bse769tH52w=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 07:00:56 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id DBB3548;
	Tue, 22 Mar 2022 23:00:54 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 76r19UJOjst5; Tue, 22 Mar 2022 23:00:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 6696B40;
	Tue, 22 Mar 2022 23:00:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 6696B40
Date: Tue, 22 Mar 2022 23:00:51 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
cc: cocci@inria.fr
In-Reply-To: <b77b2358-50fb-69ff-3205-52781e6bf405@univ-grenoble-alpes.fr>
Message-ID: <ec26179-1de1-35a-1bd3-c33151f939cb@ewheeler.net>
References: <4fc9237-ca2-518a-3221-9770f6112c6@ewheeler.net> <b77b2358-50fb-69ff-3205-52781e6bf405@univ-grenoble-alpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Does SmPL support regex groups?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 286
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/ec26179-1de1-35a-1bd3-c33151f939cb%40ewheeler.net>

On Tue, 22 Mar 2022, Nicolas Palix wrote:
> For the record, is it the expected SmPL ?
> 
> @ fu @
> identifier F,file_chooser;
> parameter list PL;
> expression list EL1, EL2;
> constant U =~ "untitled";
> @@
> 
> F(PL)
> {
>     ...
>     file_chooser = Open_Filechooser(EL1, U, EL2);
>     ...
> }
> 
> @script:python py@
> U << fu.U;
> C;
> @@
> 
> print U # Rewrite U to extract the extension
> coccinelle.C = cocci.make_expr("\".gplot\"")

The extension varies, there were half a dozen or so: I had to replace 
several Open_Filechooser() calls that had different extensions.  Here is 
the diff for that commit:
    https://github.com/KJ7LNW/xnec2c/commit/9fb0381c24365311e3bb1fc8158f18112864ebfb#diff-1d0efcfbefd013aedf0477bd522a1e4506339c5ef239a6ef770f39270747c14cL222

Here is one such diff for .png:
  file_chooser = Open_Filechooser( GTK_FILE_CHOOSER_ACTION_SAVE,
-      "*.png", NULL, "untitled.png", rc_config.working_dir );
+      "*.png", NULL, get_nec_filename_stem(newfn, ".png", PATH_MAX),
      rc_config.working_dir );

I'm not so familiar with Python, so forgive my likely incorrect syntax, 
but this might work:

	coccinelle.C = re.match("(\..*)$", U).group(1)

-Eric

> @ replace_untitled @
> identifier F,file_chooser;
> parameter list PL;
> expression list EL1, EL2;
> constant fu.U;
> expression py.C;
> @@
> 
> F(PL)
> {
> +   char newfn[PATH_MAX];
>     ...
>     file_chooser = Open_Filechooser(EL1,
> -       U,
> +       get_nec_filename_stem(newfn, C, PATH_MAX),
> 	EL2);
>     ...
> }
> 
> 
> 
> -- 
> Nicolas Palix
> 
