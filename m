Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A2AC282D6
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1+B3rMYSVR03ft2KwtD71VoyHSPoRijyZQbUqoCMt0o=;
  b=OJHKENIKjKLUZTlCNXYKlpJmuBXadVyhfPY2ef+x+S1iwwH8+O20j/UW
   hKVdzfS3JW9FRulM3bfseZg09PIaRrWjwE2CY+nYg8ghf3DvKatBo71NK
   ZkZRXIcKa2VQac+dzOyk3TAXFwjiSu12Hr1/lJd+JbuQDQsNLJlxNkuLk
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@bootlin.com
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211070015"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:09 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 90565E1152; Tue,  4 Mar 2025 10:58:46 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 48876E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 18:35:35 +0100 (CET)
IronPort-SDR: 67c5e866_KoElIOh4KQzd+jm/6dy9B+aeDnPG0fkd5jvE9aGvUdRGiO4
 D9lyHh6+JVuTFfGyvGlJ8rffqC8V8eTapyJCo0g==
X-IPAS-Result: =?us-ascii?q?A0HUAADI58VnjsO3RtlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRH1ZNAcISIRWkXADoBIPAQMBDTsJBAEBAwSFAAKLFQIfBgEENBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFDjuFew2CYgGBJ?=
 =?us-ascii?q?IEmAQEBAQEBAQEBAQEBHQINB3YBAQEBAgEjBBkBATcBBAsLGAICJgICVgYTg?=
 =?us-ascii?q?wIBgkEjBw2uU3p/M4EBggwBAQbcIIFlAwaBGi6FbIJjAYVShBZ6Jw+BVUSBF?=
 =?us-ascii?q?TKCRzE+hEODW4JphByCV2eBbIpTHC2CJYpYjlNICnt4LAFVEw0KCwcFgSlIA?=
 =?us-ascii?q?zUMCy4VIw+BFAU0QTqCC2lJOgINAjWCHnyCK4IXgjeEPYRAgWODb4IRgV0DA?=
 =?us-ascii?q?xYPAYMfdxyEfIRqHUADCxgNSBEsNxQbQwFuB6B3ATqEQoEIGRgEgRR9HpMag?=
 =?us-ascii?q?z2vUjQHhB6BXQYMiimVME0WqkCYfYVRiDSbLIF+I4FcTSODN08DGQ+OIRkfg?=
 =?us-ascii?q?0Jqx15FMgI6AgcBCgEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
 3YL
IronPort-Data: A9a23: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
 WzfHwOw3oxd5pDfVWbFdT7kbW+YxM9nxvSHEZI=
IronPort-HdrOrdr: A9a23:ZGJH1qCoaNCuoJPlHemW55DYdb4zR+YMi2TDsHoBLCC9E/bo9f
 xG885x6faZslwssRIb6LO90cC7KBvhHPhOjrX5Vo3OYOCJggeVBbAnybTZ+jPlcheeysdtkY
 NeSZJzD9DLDUV35PyV3ODBKbYd/OU=
X-Talos-CUID: 9a23:4M2tR2Deab4uJaX6E3hM9kITNdouTmTQ1krtCFeVBDxxR6LAHA==
X-Talos-MUID: 9a23:NlMFHQbVmoeBROBT7WbDvi8/btVT+qmzDRsNjqUi59jVHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="110535936"
X-MGA-submission: =?us-ascii?q?MDE52YpIUkNder+u8jpUgHdHNkCrBrqvh3n/pn?=
 =?us-ascii?q?sXAdvk2O7ba+jQ8URkvPfMAQxY165N6xLlRB8EsM76FWOl8yv6THFi9e?=
 =?us-ascii?q?bIccR0VeG3UXEIjopLmU3LuyjsasbrShBp5T3wrWrPHDrmV7H8qRKTlZ?=
 =?us-ascii?q?UN2Qa9crcuxP6Two4b4QeMOQ=3D=3D?=
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:35:35 +0100
Received: by mail.gandi.net (Postfix) with ESMTPSA id E4CDA20470;
	Mon,  3 Mar 2025 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741023334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+B3rMYSVR03ft2KwtD71VoyHSPoRijyZQbUqoCMt0o=;
	b=B8pE0DrFNC5cSUAeeQMp0HlRdACeO0lzkrjtJs6ARb0TutXQnTlM8PNXApUTcyjjj5tXOu
	y2l8Py5hbgmcZsKxvI9uPkPI+wDFDqQK4ZU7hJ2GW1tB0QcC4pjeTSicuJpQJKaOElCz0R
	wRpwl9MJoPeeaHWTqo6VCBqNMi5/VqdprD7PnF4OjaSIDJUBwEJK35Oz1h337Q+luyQqMa
	wNBbhEwg5x/VSh6r1c/3KfHJsgcNI6YL9rjSPnGc1hzoLdfXQfoCk73ePXtsaO6sag0wqD
	zRCeCtPHMs603ADv5fI/GRVBUINw4TnVVCdINJqnPAM0gZBRhlZoRVh4cAUoWg==
Date: Mon, 3 Mar 2025 18:35:32 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, Ariel
 Elior <aelior@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Manish
 Chopra <manishc@marvell.com>, Paolo Abeni <pabeni@redhat.com>, Ram Amrani
 <Ram.Amrani@caviumnetworks.com>, Yuval Mintz
 <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr, LKML
 <linux-kernel@vger.kernel.org>
Message-ID: <20250303183532.580eb301@kmaincent-XPS-13-7390>
In-Reply-To: <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
	<1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
	<f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
	<6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
	<Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
	<325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
	<64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
	<a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelheehveeuvdfhgfeukeethedvheduuedvudduteehledtheelleekffelvdefheenucffohhmrghinheptghmuhdrvgguuhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopeforghrkhhushdrgfhlfhhrihhnghesfigvsgdruggvpdhrtghpthhtohepmhhitghhrghlrdhsfihirghtkhhofihskhhisehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhto
 hepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhjrghnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheprggvlhhiohhrsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
X-GND-Sasl: kory.maincent@bootlin.com
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [RESEND] qed: Move a variable assignment behind a null
 pointer check in two functions
Reply-To: Kory Maincent <kory.maincent@bootlin.com>
X-Loop: cocci@inria.fr
X-Sequence: 2514
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/20250303183532.580eb301%40kmaincent-XPS-13-7390>

On Mon, 3 Mar 2025 11:28:29 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Mon, Mar 03, 2025 at 09:22:58AM +0100, Markus Elfring wrote:
> > > The assignment:
> > >
> > > 	p_rx =3D &p_ll2_conn->rx_queue;
> > >
> > > does not dereference "p_ll2_conn".  It just does pointer math.  So the
> > > original code works fine. =20
> >=20
> > Is there a need to clarify affected implementation details any more?
> > https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereferen=
ce+null+pointers
> > =20
>=20
> This is not a NULL dereference.  It's just pointer math.
>=20
> regards,
> dan carpenter

Feel free to ignore Markus, he has a long history of sending unhelpful revi=
ews,
comments or patches and continues to ignore repeated requests to stop. He is
already on the ignore lists of several maintainers.
There is a lot of chance that he is a bot.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
