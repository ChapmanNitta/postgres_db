CREATE UNIQUE INDEX EmailAddressIdx
ON account(email_address);

CREATE INDEX DistributorNameIdx
ON distributor(name);

CREATE UNIQUE INDEX FlavorNameIdx
ON flavor(name);
