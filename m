From: mmarek@suse.cz (Michal Marek)
Date: Tue, 10 Jun 2014 14:37:12 +0200
Subject: [Cocci] [PATCH V2] coccicheck: Add unneeded return variable test
In-Reply-To: <1401646351-12474-1-git-send-email-peter.senna@gmail.com>
References: <1401646351-12474-1-git-send-email-peter.senna@gmail.com>
Message-ID: <5396FBF8.2060700@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2014-06-01 20:12, Peter Senna Tschudin wrote:
> This semantic patch looks for variables that are initialized with a
> constant, are never updated, and are only used as parameter of return.
> Return the constant instead of using a variable.
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

Applied to kbuild.git#misc, thanks.

Michal
