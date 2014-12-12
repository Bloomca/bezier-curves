/* globals module */
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
      all: {
        expand: true,
        bare: true,
        cwd: 'app/coffee/',
        src: '**/*.coffee',
        dest: 'app/js/',
        ext: '.js'
      }
    },
    sass: {
      dist: {
        options: {
          sourcemap: 'none'
        },
        files: [{
          expand: true,
          cwd: 'app/sass',
          src: ['*.sass'],
          dest: 'app/css',
          ext: '.css'
        }]
      }
    },
    watch: {
      coffee: {
        files: ['app/coffee/**/*.coffee'],
        tasks: ['coffee', 'sass']
      }
    }
  });

  // Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');

  // Default task(s).
  grunt.registerTask('default', ['coffee', 'sass', 'watch']);

};