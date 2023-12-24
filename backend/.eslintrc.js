module.exports = {
    parser: "@typescript-eslint/parser",
    plugins: ["@typescript-eslint", "prettier"],
    extends: ["eslint:recommended", "plugin:@typescript-eslint/recommended"],
    parserOptions: {
        ecmaVersion: 2021,
        sourceType: "module",
    },
    rules: {
        "@typescript-eslint/no-unused-vars": "off",

        // "@typescript-eslint/consistent-type-definitions": ["error", "type"],

        // "brace-style": ["error", "allman"],

        // "indent": [2, 4, {"VariableDeclarator": 0}],

        indent: [2, 2, { VariableDeclarator: 0 }],

        "brace-style": [2, "allman"],

        // "brace-style": "off",

        // "@typescript-eslint/brace-style": ["error", "allman" ,{"fix": true}],
    },
};
