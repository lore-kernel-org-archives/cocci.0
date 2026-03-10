Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD61EB1058
	for <cocci@archiver.kernel.org>; Tue, 10 Mar 2026 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=u1O5Z146YMk8FHwWYHIeq5l+sJXYGn84l3Uu3PDpBrg=;
  b=s6mKZEN22opliCuCwtYWCpF/31qrp6KZdRx6U9J789jwYkW59jFlZRwp
   jSwOlLm92iDs7msgPgsiiQc0phw2kWqcN+leV7rE8eqc0HzEAlYwpxovW
   85xZh2IGxZhEY0gMcuFJ/QTT4b73BOYV5AMlep7N0hblmsNMjK0/I/TON
   s=;
X-CSE-ConnectionGUID: 2dwrpaolSqSN7xCHlZCCOg==
X-CSE-MsgGUID: Gtnk+pVcT9WHiScLCcGVsg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="267117288"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Mar 2026 15:25:27 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 160CA839AA; Tue, 10 Mar 2026 15:25:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4C40E83911
	for <cocci@sympa.inria.fr>; Tue, 10 Mar 2026 15:16:55 +0100 (CET)
X-CSE-ConnectionGUID: 7EZbhGJtTrykF2fJJmfTbQ==
X-CSE-MsgGUID: tSa8Szl7TWCOqwzT/9Ff3Q==
IronPort-SDR: 69b027d3_M92ibTrETk/G9Kbgrvs29PAP+aMufchMQCJEu3k2LVuzh/X
 w6Ls/xiftj3V5rrvpcNq0Ujd3reudqZmig4xqEQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EAAwDyJrBpgRAsKNhaHQEBAQEJARIBBQUBQIFQgkGBZ?=
 =?us-ascii?q?TEDBwhJjVOIfKAZDwEDAQ1RBAEBhH0KAo0iIAYBBDQTAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQEBAQ0BAQUBAQECAQECBAYBAhABATsHDgkyhlyCYgGEAAEBAQIBOj8FC?=
 =?us-ascii?q?wsOOFYGE4VPJwMFrUeBNIEB4C4VgTiIVAGFWhqEekKCDYEVNYJ1PosHBIIig?=
 =?us-ascii?q?Q6JCooWSAp4HANZLAFVEw0KCwcFXkVDAzUSKhUjSwUtHYEjIR0XFB9YGwcFE?=
 =?us-ascii?q?iEqgUl4ggEPhmp5Ay5eGg4iAjpcSj4LWgWCPwMLGA1IESw3FBtCbgeNdD6CN?=
 =?us-ascii?q?YEVmTIBjiaheYQmhHCcaE2DcaZ6LodVEJBzqUEBgX4jgVwzGggoCIMiTwMZD?=
 =?us-ascii?q?45fzRsqMjwCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
 qzaogY7xvqER8s7bnofV4oAcHkxXZ/j8xM=
IronPort-Data: A9a23:U6uEdqiyzL+zkKjDrt5Lh0wZX161VBQKZh0ujC45NGQN5FlHY01je
 htvUT/QbP7ZZzenLtt3PoXl9x8Ou5/cyNBkSVE4pCk1RC9jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+e6VaidfHgsGGeIcQ954Tp7gek1n4V0ttawBgKJq
 LvartbWULOf82cc3lk8teTZ83uDgNyo4GlG5gdnPagS1LPjvyB94Kw3dfnZw0TQGdE88t6SH
 47r0Ly/92XFyBYhYvvNuqr7aEADXonJNgGIjHdMM4D66vSVjnFaPg4TbZLwWG8P49m7t4gZJ
 OZl6fRcfTwU0pjkw4zxZfX3/xZWZsWq8JefSZS2XFf6I0fuKxMAyN02ZK060BFxFk+azgii+
 NRBQA3hYCxviMrp7YCxSsZOmvg5PcrFZo09mHRu8TvgWKNOrZDrG80m5PdC0TM5l4ZOGu3Ca
 sYUbDNuaFLLZBgn1lU/Ustg2rvwwCWjNWQGwL6WjfJfD2z71gtqzLXhLPLafduGQMRO2EGCq
 Qoq+kygXklLb4HBk2LtHnSEmtTGzRjpXN0uK5af7+F4vBrC6GJIMUhDPbe8iaXi1BTgCrqzM
 Xc8/iMxpKw23F6qS9PnVlu5pmSFt1gSQbJ4GOox4wCl0bvR+w/fB24eTzcHZsZOiSMtbScvy
 keTktfgFGQ36ePTSXWG6rqYoDa7OCxTJmgHDcMZcecby4bOkoszoTDTcsxyE4DvgP/XHD/My
 Qnf+UDSmI4vYdg3O7KT1nmvvt5BjoPMUhYv6wHeTzr9t10/ZIm+e4Gk5F3S7PIGJ4GcJrVgg
 JTms5jChAztJcvV/MBofAnrNO/xjxpiGGCG6WOD57F7q1yQF4eLJOi8Gg2S23uFwu5YImGzP
 h67VfJ5+IJYO2SxK6RwZsq6DIJC8JUM4e/ND6iOBvIXOsYZXFbeoElGOxTNt0izyxJEuf9kZ
 v+mnTOEVydy5VJPl2LuH791PH5C7nxW+F4/sriikE34iefHOSLKIVrHWXPXBt0EAGq/iF292
 75i2wGikn2zicWvPXGFwp1ZNl0QM3kwCLb/rsEdJKbJIRNrFCtlQ7XdyK8oMd4t1alEtPb6z
 lfkUG9hyX37mSLmLyeOYStdc7/BZ8t0gk86Gi0OBmyW/UYfT7yh14olTKtvT4IbrLRi6dVWU
 8g6f96xB6UTazbfpBUYQ5rPjK1jUxWJgwjUbimvXzwtW5sxVj7Y28TFezH3/3IkFRuHtsoZo
 pyh2DjEQJEFeR9QMcbOZN+rzHKzpXI4mtNtb3DXI9JWRlrgwLJqJwP1kPUzBcMGcjfH+Re3y
 CeUBk0+idTWgopo7uTMu7+In72pH8R6AEBeOWvRtpSyFCvC+1uc0Z1ya/mJcR/dRVHL1v2bP
 8sN9M7FMdoDgFpumKh/GewyzasBuv3el4UDxQFgRHj2f1CnD417GUa/3O5Ni7Zsw4FIsg7nS
 2ON/dhnYY+yAv3HK2JIBgQZbbWk78o2yx3y9vU+JXvo6BBnpISnVVpgBDjSqSh/AoYsDqYb7
 7YAgvMG0y2+lRsgDfiehA926WmnDyINQocnhL4gEa7pjQsgz29ZUKzfFybZsYODROtPAHZzI
 jarm7fz3eVA50vdckgcEWrG8vpdiK8v5jFL7g4mDHaYluXVgsQY2EVqzg02aQBO3zN70+5XE
 Up6BX1ffKmh0W9hu5leYjqKBQpEOiy8xmXw7Fk4zEviUEiiUz32Hl0XYOqi0hgQzDNBQ2J94
 rqd9WfCVATqduHX2g8ZexZsi97nfOxL2jzyouKVNOXbIMBiehvguLGkWkQQoRi+Ac8RulzOl
 dM3wMlOM5/EJQwiiIxlLbKF1IYgagGOf01DZvBDwJknP0/hfBOK5DzfDHzpJ+1sIaTR/F6aG
 v5eAJtFdy6D2RakqhEZAq8xIIFIosM52epaRJTVIT8pjrjOiBtor5PayQbmjkAJXdhFsJgwO
 6HRRR24A02SgnpmwT7TnuYdImGpPMcPYQb9+MuX8+w5MY0Jn88xUEM105qy5260Nik+9T2qn
 QrzXY3k5M089pZNxa7CSr5iASewIvPNDNW4yhi56YlyXImeIPXwuBMwgXi5GQZvZJ86ecl9z
 JaJu/7JhHL1hq48CT3lqsPQBptyxJuAWcRMOZjKN1hcpyyJXfHs7zYl+2yVLZ9okstX1vK4R
 jmXOdeBStoIZ+hznHFlSTBSMxI4OZTFaq3NoSCcrfPVLjM/1QfBDs2s9F63TGV9WxILBabDC
 V7Pi67z3uxbkYVCOkZVTbUuSZp1O0TqVqYaZsX8/2vQRHWhhlSZ/KDuj1w84DXMEWOJC9v+/
 YmDfBXlaRCuo+vd+bm1aWCpUsE/Vx6RQNXcf37xP/ZshjSzHSgGKv8BPJkLD5hVlmr505SQi
 PTlcj45ESukNdhbWUyU3Tghdl736i8y1hPRKTsu80aVcGGxHozo7H5J6HJ7+3kvEtf85LjPF
 Dzdk0Ec+jC+xZZlQOcIoPuhjo+LAx8cKm0goSjAriA5P/rS7XjmGpCs8MqhmBEry/3wqXg=
IronPort-HdrOrdr: A9a23:P6QbNqzDOMbJgEKEr1JbKrPwkL1zdoMgy1knxilNoNJuHPBw8P
 re+sjztCWE7wr5N0tMpTntAsW9qDbnhP1ICOoqTNOftWvd2FdARbsKheCJ/9SjIVydygc378
 ZdmsZFZ+HYPBxaoYLf7BSxeuxQvuWvweSIqaPix3kFd3AUV0gZ1XYdNi+rVnZtXQFDCN4ACJ
 aB6o5mqlObCA4qR/X+PWMdV+zP4+fGj43renc9dmUawTjLtz+z8r79FFy5834lIk9y6IZny2
 TeiQz+4eGGu+q4xgS07R6v031JoqqY9vJzQPaQgtVQEDXjjQ60eJ9sMofyxQwInA==
X-Talos-CUID: 9a23:gy6tt2NB1lW2Mu5DBwRV/k47ONwZaGze4i3eAW29B1pjcejA
X-Talos-MUID: 9a23:08X9Pwo1eGWmpZ21v/Eezy1ZPZdT8aDxNH8mtowZqfXDZAJ+YA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,112,1770591600"; 
   d="scan'208";a="140935620"
X-MGA-submission: =?us-ascii?q?MDF461uExRRY9wCpVYXvlan0PmsPeNJPgibAeo?=
 =?us-ascii?q?VbKHJ3N+fSjKH3AbA64whRL9WWhBbgxRZL5fXtLPAejQrXRvWLr9w9Dv?=
 =?us-ascii?q?q9+ZweChL69087JD/YuWoVCW/pUQNCpDuwX7ykcvXeLFhEYmwDo75oQh?=
 =?us-ascii?q?PY4bez/fr67bQ2P6QfTiqiDg=3D=3D?=
Received: from smtprelay0016.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 15:16:50 +0100
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id B7013B6547;
	Tue, 10 Mar 2026 14:16:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id D3F9D2000E;
	Tue, 10 Mar 2026 14:14:32 +0000 (UTC)
Date: Tue, 10 Mar 2026 10:14:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Julia Lawall
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Chris Mason
 <clm@fb.com>, David Sterba <dsterba@suse.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, Viacheslav
 Dubeyko <slava@dubeyko.com>, Theodore Ts'o <tytso@mit.edu>, Andreas Dilger
 <adilger.kernel@dilger.ca>, Steve French <sfrench@samba.org>, Paulo
 Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Eric Van Hensbergen
 <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique
 Martinet <asmadeus@codewreck.org>, Christian Schoenebeck
 <linux_oss@crudebyte.com>, Gao Xiang <xiang@kernel.org>, Chao Yu
 <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, Hongbo
 Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, Miklos
 Szeredi <miklos@szeredi.hu>, Konstantin Komarov
 <almaz.alexandrovich@paragon-software.com>, Andreas Gruenbacher
 <agruenba@redhat.com>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Jan
 Kara <jack@suse.com>, Phillip Lougher <phillip@squashfs.org.uk>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Max
 Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, John
 Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Andrew Morton <akpm@linux-foundation.org>, Alasdair Kergon
 <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
 <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Trond
 Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Jon Maloy <jmaloy@redhat.com>, Johannes Berg
 <johannes@sipsolutions.net>, Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, John Crispin <john@phrozen.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi
 Wang <zhi.wang.linux@gmail.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Alex
 Deucher <alexander.deucher@amd.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Sandy Huang <hjc@rock-chips.com>, Heiko
 =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Igor Russkikh <irusskikh@marvell.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Michael Chan <mchan@broadcom.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Taras Chornyi
 <taras.chornyi@plvision.eu>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Iyappan Subramanian
 <iyappan@os.amperecomputing.com>, Keyur Chudgar
 <keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Gregory
 Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Vinod Koul <vkoul@kernel.org>, Linus
 Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, Eduardo Valentin
 <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Alex Williamson
 <alex@shazbot.org>, Mark Greer <mgreer@animalcreek.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Lee Jones
 <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Dave Penkler
 <dpenkler@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Justin Sanders
 <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>, Georgi Djakov
 <djakov@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Pali =?UTF-8?B?Um9ow6Fy?=
 <pali@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-ID: <20260310101220.24a5c5e9@gandalf.local.home>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: t3hdewhrhasw7f3gorx5jroa8bfttu61
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D3F9D2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/9Mzn/qfZFEp1e7RgFq11s4n8TXcGF42g=
X-HE-Tag: 1773152072-399195
X-HE-Meta: U2FsdGVkX1/sr455L+OeqDWIUsSflk6pOnirfnKU4P+1ptXPBptvvQtdgLpKUro5xpE5mwL9OSxc8De42fWUKW3UA0xDjLt8deOx7Rt+YD2zdLsgLNPt+GtW9t0OIk6HGza/DLYz3Vzwa6W2j9RFRkt0u8kU/4nSdzQFXg0XUCPq0O7Zih2HPR5kbJC2dqX8fgpgG6kXbyGWAJWC5H8NEAgNiaeFS1ibRza8HlDqKtmihYdG70k1ID4dNk90G/xB/tCbIhXs0SuHsvdkjj/J9rzzD7qFP/bRWTfcgm+WhH9Nv5Rz067I1rPqmO4dO7ez
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual
 NULL check - refactor
Reply-To: Steven Rostedt <rostedt@goodmis.org>
X-Loop: cocci@inria.fr
X-Sequence: 3382
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/Mh11kSaEOJEdY5LH4e1SlA>

On Tue, 10 Mar 2026 12:48:26 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.


Honestly, the IS_ERR_OR_NULL() looks worse in a lot of the locations you
updated. Just because we have IS_ERR_OR_NULL() doesn't mean we need to go
and replace every location that can use it.

NAK for any code this touches that I'm responsible for.

-- Steve
