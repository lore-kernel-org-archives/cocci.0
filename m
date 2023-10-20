Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CC0CDB47E
	for <cocci@archiver.kernel.org>; Fri, 20 Oct 2023 07:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0I4B/8CTK4qnj6ucomdSZ40vJzcwkurbepj5fwDVLnU=;
  b=c7bX7jfEL8RTDyRJwRI1Ou7ZMvP+qkBgrCS8bhtJTavuMwTwvktj933K
   cvbslB3pB1htPAInF4fzjZu14qEuPrOCopw1MrJmDRmbVQ1aD7nQOJff0
   HnEW+r8n2Gw0zK3kQQ6tO9uBl5HFqN74XCK03dcA5GjojzZzNaECYx/Jj
   8=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208";a="132266996"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Oct 2023 09:54:41 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 99DDEE0CD6; Fri, 20 Oct 2023 09:54:40 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1770FE00B7
	for <cocci@sympa.inria.fr>; Fri, 20 Oct 2023 09:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:subject:message-id:mime-version;
  bh=0I4B/8CTK4qnj6ucomdSZ40vJzcwkurbepj5fwDVLnU=;
  b=XEIu7ssPzlWzknai/c+eixl9fdBNwo/nc39bdkC6hOMLYBSfD7QTQFhE
   3C8ZaWGEJQCdIl9LnuG3kV5Ym5kKlBY6z8PhJ2sNIJb2VJOshvUaYw30U
   SK3Fh8PYNYlKu6iDpv56kkbnAV0wNZxD1/3I9KCNYfScDH0DpsqPZWwf8
   4=;
X-IronPort-AV: E=Sophos;i="6.03,238,1694728800"; 
   d="scan'208";a="69264207"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:54:39 +0200
Date: Fri, 20 Oct 2023 09:54:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: cocci@inria.fr
Message-ID: <349be17d-6918-2733-59db-cad17959b9ac@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: [cocci] Sorry for the spam!!!
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1264
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/349be17d-6918-2733-59db-cad17959b9ac%40inria.fr>

Hi,

I'm sorry, but I clicked the wrong button in the mailing list management
interface.  Very sorry for the inconvenience.

julia
