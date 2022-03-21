Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055F1C433F5
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 22:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=VLLXOrk5veHE5wPlknx0aQ0pFtN05ehOUU9tzcUw9SQ=;
  b=OvOomIC9mUKrZuuKVZHiHeDySvx3nZIoArwgRQTiT+5bR0K/2sP4vvSP
   AcQaLkR8F1Llp56gNJWQVaeQ2219HQenkWgMBomyXgAkJw51umuTMyokH
   R1a8Bcn0+0qWh+ja0FaS3xqxBQ0E2ufIwHq700D+O33RsVah9ATDnkq1y
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27325406"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 23:51:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DCC28E0210; Mon, 21 Mar 2022 23:51:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D82E7E0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 23:51:04 +0100 (CET)
IronPort-SDR: 5KHapxJN8AOFu1BbMWK0tM8ThUhozfBmvLVdYtV875j4rtqLMWL9kNfufYB7tJpdHZvj0r2KXS
 e3/01fRxgYHqnX6Heg4OkCRzVroKKu9ULU1zJnddWtWNxZj/D/rrxDJ0mHCM8JL/UPVB9CzVPW
 IPBJmPT07B8xmyvnPOS0oo8O/lujyGuQ08S3nAPPqN9lwQu8wOkpvcx+5srPDmSguAEgzUPdll
 zMipb/q3QBpot3Kqc/IMVkwNncpCa2sAaR/tGwT2fpDY8nTRXmwYsqTcryz8ztpg1xKHvkm0xI
 zjFeOxpd+cvNeYni7fB2znaS
X-IPAS-Result: =?us-ascii?q?A0BIDwBmADli/0Xcza1aHgENLwwOC4FiA4ImB4FNAQEBK?=
 =?us-ascii?q?QQLhRiRG4QfmEWBewsBAwENQQQBAYUHAlEFg2YCHQYGNgQNAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQMBAQUBAQECAQECBAQBVjIsAWMBZwGBTgGBeQYEPYI1KQGDZAEFI?=
 =?us-ascii?q?1YQCxgqAgJXBoMXgxetN4ExgQGJe4E9jkgnHECBTYE8gwM+h1+CZQSuSo86V?=
 =?us-ascii?q?J4Wg1OfXgYULpZJkXWWW6cCgT88DBaBWR8UGggmCoMlTQECAQIBDAECAgECA?=
 =?us-ascii?q?QIBAgEIAQECAZ0MIQEBAWkCBgEKAQEDCZBSAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:bOD55Kjx4ATlIE0DsX8xv2k4X161UxYKZh0ujC45NGQN5FlHY01je
 htvDGDVaP+PZGehL4tzO4q/8BgEvseByNI1HVZvqChmE3tjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKidUsxIbVcMpB0J0HqPoMZkxN8w6TSFK1nV4
 4mq+JeGYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Nplk8e3Ti51Iqf1tMMbdFp8GQtEG4RP9+qSSZS/mZT7I0zudmuqzupuAUwyMJde/OtraY1M3
 aVHc3ZXNk3F3bjuhuzqIgVvrpxLwM3DN4QUsXBIyTDCEe1gTI/DTqjO6MUe2jos7ixLNaeHN
 pZDMWAHgBLobw0XYFALU6wFv+qjmUD0bGB/t1evuv9ii4TU5FctjuO8b4q9lsaxbc5SlU2Zj
 nnX+nzwRBAcLt2WjzSfmk9AncfKjWX2R4IfGbm17LhsjUH7KnEv5AM+cwC8ptDllkSHd/VZD
 A8w8AAUi4E7+xn+JjXiZCGQrHmBtx8aftNfFewm9Q2AopbpDxal6nssFWEeNYR33CMibXl7i
 Q/TxoKB6SlH6eXNERqgGqGoQSRe0BX5wEcHdWkJUgsI7t3uusc1gw6nojdf/Eyd1Yyd9dLYm
 WziQM0Ca1M7155jO0KTpwivvt5UjsKVJjPZHy2ONo9lhysgDGJfW6Sm6ELA8dFLJ5uDQ1+Ks
 RAswpbCs7BeUs/XyX3RHY3h+Y1FAd7eaFUwZnY0QvEcG8mFoSP9FWyuyG4WyLhV3jYsImO3O
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
IronPort-HdrOrdr: A9a23:FPXRzairtA34GEnILEkYciJnxXBQXt4ji2hC6mlwRA09TyX4rb
 HWoBx4vSWatN9/Yh8dcLy7WZVoBEmskKKdgrNhW4tKPjOW3FdARbsKheCOrwEIWReOkdK1vp
 0QEZSWZueRMbGkt6zHyQOzeuxQo+W6zA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="9194202"
X-MGA-submission: =?us-ascii?q?MDFp7X5OMXpzQyTr8gBtoiEG2jlj0c4MjiSKik?=
 =?us-ascii?q?4tFB7tQAJAi0Pxdn+6VLsuXvpUtIPIa8KrPrpKgh58RoCnbtV8i0WtMz?=
 =?us-ascii?q?qYLMBLWIGP87WALOqtUxXewhCwxv+6wmGdIcleSyLH+H+B0X/jBGysft?=
 =?us-ascii?q?pYNGZ13rSDZ1qP9P5JOCftLw=3D=3D?=
Received: from mx.ewheeler.net ([173.205.220.69])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 23:51:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id DCDC081;
	Mon, 21 Mar 2022 15:51:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id T35iH57GqqYl; Mon, 21 Mar 2022 15:51:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 02B1041;
	Mon, 21 Mar 2022 15:51:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 02B1041
Date: Mon, 21 Mar 2022 15:50:58 -0700 (PDT)
From: Eric Wheeler <cocci@lists.ewheeler.net>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <d5840b8b-9ef0-b078-592d-d5a66cffb775@web.de>
Message-ID: <7bcf6d61-b4d5-81fd-b117-1c44f6b2bd67@ewheeler.net>
References: <a28111b-90ab-1d57-58de-113a50f61f41@ewheeler.net> <trinity-aa278557-9b21-4086-848b-218a903ce0ee-1647853331428@3c-app-webde-bap05> <6355cbc2-9bb1-3c72-43d3-a02e48df52e@ewheeler.net> <d5840b8b-9ef0-b078-592d-d5a66cffb775@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-41027309-1647903060=:28642"
Subject: Re: [cocci] Is there a stringify operator?
Reply-To: Eric Wheeler <cocci@lists.ewheeler.net>
X-Loop: cocci@inria.fr
X-Sequence: 282
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/7bcf6d61-b4d5-81fd-b117-1c44f6b2bd67%40ewheeler.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-41027309-1647903060=:28642
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 21 Mar 2022, Markus Elfring wrote:
> >>> 	@ r2 @
> >>> 	type r1.T;
> >>> 	identifier r1.I;
> >>> 	@@
> >>> 	++printf(#I " has a datatype of " #T "\n");
> >> Do you need any extra debug information?
> >>
> >> Are you looking for further advices so that more source code transformation
> >> alternatives will become interesting?
> > What do you mean?
> 
> 
> I assume that the shown print statements (besides the usage of the macro “STRINGIFY”)
> are connected with special data processing requirements which can eventually
> be handled better with advanced SmPL scripts.

If by "advanced" you mean a stringify operator, then sure. You could add a 
stringify operator to SmPL if thats what you wish to do.  I used "#" 
above, but otherwise SmPL is fine and I can hack in macros as needed.


--8323328-41027309-1647903060=:28642--
