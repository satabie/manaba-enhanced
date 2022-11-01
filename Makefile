eslint = yarn run eslint --ignore-path .gitignore
prettier = yarn run prettier --ignore-path .gitignore

install:
	yarn install

format:
	$(prettier) --write .

format.check:
	$(prettier) --check .

lint:
	$(eslint) .

lint.fix:
	$(eslint) --fix .

autofix: format lint.fix

dev.chrome: install
	NODE_ENV=development BROWSER_ENV=chrome yarn run webpack --watch

dev.firefox: install
	NODE_ENV=development BROWSER_ENV=firefox yarn run webpack --watch

build.chrome: install clear
	NODE_ENV=production BROWSER_ENV=chrome yarn run webpack

build.firefox: install clear
	NODE_ENV=production BROWSER_ENV=firefox yarn run webpack

sign.firefox: install
	yarn run web-ext sign -s dist --api-key=${AMO_JWT_ISSUER} --api-secret=${AMO_JWT_SECRET}

clear: install
	yarn run rimraf dist

typecheck: install
	yarn run tsc --noEmit

typecheck.watch: install
	yarn run tsc --noEmit --watch
