require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest
  # Pruebas para rutas de transactions
  test 'routes to transactions index' do
    assert_routing '/transactions', controller: 'transactions', action: 'index'
  end

  test 'routes to transactions show' do
    assert_routing '/transactions/1', controller: 'transactions', action: 'show', id: '1'
  end

  test 'routes to transactions new' do
    assert_routing '/transactions/new', controller: 'transactions', action: 'new'
  end

  test 'routes to transactions edit' do
    assert_routing '/transactions/1/edit', controller: 'transactions', action: 'edit', id: '1'
  end

  test 'routes to transactions create' do
    assert_routing({ path: '/transactions', method: :post }, { controller: 'transactions', action: 'create' })
  end

  test 'routes to transactions update' do
    assert_routing({ path: '/transactions/1', method: :patch }, { controller: 'transactions', action: 'update', id: '1' })
    assert_routing({ path: '/transactions/1', method: :put }, { controller: 'transactions', action: 'update', id: '1' })
  end

  test 'routes to transactions destroy' do
    assert_routing({ path: '/transactions/1', method: :delete }, { controller: 'transactions', action: 'destroy', id: '1' })
  end

  # Pruebas para rutas de sesiones
  test 'routes root to sessions new' do
    assert_routing '/', controller: 'sessions', action: 'new'
  end

  test 'routes to sessions create' do
    assert_routing({ path: '/login', method: :post }, { controller: 'sessions', action: 'create' })
  end

  test 'routes to sessions destroy' do
    assert_routing({ path: '/logout', method: :delete }, { controller: 'sessions', action: 'destroy' })
  end

  # Pruebas para ruta de dashboard
  test 'routes to dashboard index' do
    assert_routing '/dashboard/index', controller: 'dashboard', action: 'index'
  end

  # Prueba para health check
  test 'routes to health check' do
    assert_routing '/up', controller: 'rails/health', action: 'show'
  end
end
