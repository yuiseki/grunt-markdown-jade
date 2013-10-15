module.exports = (grunt) =>
    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        m2j:
            compile:
                files:
                    "public/articles.json" : ["articles/*.md"]
        md2html:
            options:
                layout: "public/articles.template"
            articles:
                files: [
                    expand: true
                    cwd: "articles/"
                    src: ["*.md"]
                    dest: "public/articles/"
                    ext: ".html"
                ]
        jade:
            index:
                options:
                    data: (dest, src) ->
                        obj = require("./public/articles.json")
                        return {data:obj}
                    pretty: true
                files:
                    "public/index.html" : "jade/index.jade"
            articles:
                options:
                    pretty: true
                files:
                    "public/articles.template" : "jade/articles.jade"
        watch:
            md:
                files: ["articles/*.md"]
                tasks: ["m2j", "md2html"]
            jade:
                files: ["jade/*.jade"]
                tasks: "jade"
    grunt.loadNpmTasks("grunt-contrib-jade")
    grunt.loadNpmTasks("grunt-contrib-watch")
    grunt.loadNpmTasks('grunt-md2html')
    grunt.loadNpmTasks('grunt-markdown-to-json')
    grunt.registerTask "make", ["m2j", "jade", "md2html"]
    grunt.registerTask "default", ["make", "watch"]

