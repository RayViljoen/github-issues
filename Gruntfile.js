// Generated on 2014-07-04 using generator-angular 0.9.2
'use strict';

module.exports = function (grunt) {

  // Require connect mod_rewrite for html5 mode
  var modRewrite = require('connect-modrewrite');

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  // Configurable paths for the application
  var appConfig = {
    app: require('./bower.json').appPath || 'app',
    dist: 'dist'
  };

  // Define the configuration for all the tasks
  grunt.initConfig({

    // Project settings
    yeoman: appConfig,

    // Watch Config
    watch: {
        files: ['app/*.html',  'app/views/**/*'],
        options: {
            livereload: true
        },
        scripts: {
            files: []
        },
        coffee: {
            files: 'app/scripts/**/*.coffee',
            tasks: ['newer:coffee:compile']
        },
        css: {
            files: [
                'app/styles/*.css',
            ],
        },
        images: {
            files: [
                'app/images/**/*.{png,gif,jpg,jpeg,webp}'
            ],
        },
    },

    // The actual grunt server settings
    connect: {
      options: {
        nospawn: true,
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        livereload: 35729
      },
      livereload: {
        options: {
          open: false,
          middleware: function (connect) {
            return [
              modRewrite(['^[^\\.]*$ /index.html [L]']),
              connect.static('app'),
              connect.static('.tmp')
            ];
          }
        }
      }
    },

    // Empties folders to start fresh
    clean: {
      dist: {
          files: [{
              dot: true,
              src: [
                  '.tmp',
                  'app/.tmp',
                  'app/dist',
                  'dist'
              ]
          }]
      }
    },

    // Coffee Lint
    coffeelint: {
        options: {
            configFile: 'coffeelint.json'
        },
        app: ['app/scripts/coffee/**/*.coffee']
    },

    // Coffee compile
    coffee: {
        options: {
          sourceMap: false,
          sourceRoot: ''
        },
        compile: {
            expand: true,
            flatten: false,
            cwd: 'app/scripts',
            src: ['**/*.coffee'],
            dest: '.tmp/scripts/',
            ext: '.js'
        }
    },

    // ngmin
    ngmin: {
        controllers: {
            expand: true,
            cwd: 'app/scripts/js/controllers',
            src: ['*.js'],
            dest: 'app/scripts/js/controllers'
        },
        directives: {
            expand: true,
            cwd: 'app/scripts/js/directives',
            src: ['*.js'],
            dest: 'app/scripts/js/directives'
        },
        services: {
            expand: true,
            cwd: 'app/scripts/js/services',
            src: ['*.js'],
            dest: 'app/scripts/js/services'
        }
    },

    // Renames files for browser caching purposes
    filerev: {
      dist: {
        src: [
          'dist/scripts/{,*/}*.js',
          'dist/styles/{,*/}*.css',
          'dist/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}',
          'dist/styles/fonts/*'
        ]
      }
    },

    // Reads HTML for usemin blocks to enable smart builds that automatically
    // concat, minify and revision files. Creates configurations in memory so
    // additional tasks can operate on them
    useminPrepare: {
      html: 'app/index.html',
      options: {
        dest: 'dist',
        flow: {
          html: {
            steps: {
              js: ['concat', 'uglifyjs'],
              css: ['cssmin']
            },
            post: {}
          }
        }
      }
    },

    // Performs rewrites based on filerev and the useminPrepare configuration
    usemin: {
      html: ['dist/{,*/}*.html'],
      css: ['dist/styles/{,*/}*.css'],
      options: {
        assetsDirs: ['dist','dist/images']
      }
    },

    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: 'app/images',
          src: '{,*/}*.{png,jpg,jpeg,gif}',
          dest: 'dist/images'
        }]
      }
    },

    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: 'app/images',
          src: '{,*/}*.svg',
          dest: 'dist/images'
        }]
      }
    },

    htmlmin: {
      dist: {
        options: {
          collapseWhitespace: true,
          conservativeCollapse: true,
          collapseBooleanAttributes: true,
          removeCommentsFromCDATA: true,
          removeOptionalTags: true
        },
        files: [{
          expand: true,
          cwd: 'dist',
          src: ['*.html', 'views/{,*/}*.html'],
          dest: 'dist'
        }]
      }
    },

    // Copies remaining files to places other tasks can use
    copy: {
      dist: {
        files: [{
          expand: true,
          dot: true,
          cwd: 'app',
          dest: 'dist',
          src: [
            '*.{ico,png,txt}',
            '.htaccess',
            '*.html',
            'views/{,*/}*.html',
            'images/{,*/}*.{webp}',
            'fonts/*'
          ]
        }, {
          expand: true,
          cwd: '.tmp/images',
          dest: 'dist/images',
          src: ['generated/*']
        }]
      }
    },

  });

  grunt.registerTask('serve', 'Start working on this project from a connect server.', [
      'clean',
      'coffee:compile',
      'connect:livereload',
      'watch'
    ]);

  grunt.registerTask('build', [
    'clean',
    'coffeelint',
    'useminPrepare',
    'autoprefixer',
    'concat',
    'ngmin',
    'copy:dist',
    'cssmin',
    'uglify',
    'filerev',
    'usemin',
    'htmlmin'
  ]);

  grunt.registerTask('default', [
    'serve'
  ]);
};
