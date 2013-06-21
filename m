From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 21 Jun 2013 09:29:23 +0200
Subject: [Cocci] Improvements for Coccinelle API
In-Reply-To: <alpine.DEB.2.02.1306192330420.2023@localhost6.localdomain6>
References: <alpine.DEB.2.02.1306192330420.2023@localhost6.localdomain6>
Message-ID: <51C400D3.5060505@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


> A third option would be to make it possible to refer to eg virtual.xyz
> directly in the script code, regardless of the language.

I would prefer such an approach. I'd like to suggest that a specific 
function will return an object which provides access to a general 
application programming interface for Coccinelle.

Regards,
Markus
